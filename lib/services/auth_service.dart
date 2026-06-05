import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // تسجيل مستخدم جديد
  Future<User?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // إنشاء حساب في Firebase Auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // إنشاء مستند المستخدم في Firestore
      final user = User(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.id).set(user.toJson());

      return user;
    } catch (e) {
      print('خطأ في التسجيل: $e');
      return null;
    }
  }

  // تسجيل الدخول
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (doc.exists) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      print('خطأ في تسجيل الدخول: $e');
      return null;
    }
  }

  // تسجيل الخروج
  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('خطأ في تسجيل الخروج: $e');
    }
  }

  // الحصول على المستخدم الحالي
  User? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return User(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        createdAt: user.metadata.creationTime ?? DateTime.now(),
      );
    }
    return null;
  }

  // التحقق من حالة المستخدم
  Stream<auth.User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}