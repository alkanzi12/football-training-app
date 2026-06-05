import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/training_session.dart';

class TrainingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  const uuid = Uuid();

  // إضافة جلسة تدريبية جديدة
  Future<bool> addTrainingSession({
    required String coachId,
    required String title,
    required String description,
    required DateTime date,
    required int durationMinutes,
    required String location,
    required List<String> objectives,
    required List<String> exercises,
    String? coachNotes,
  }) async {
    try {
      final sessionId = uuid.v4();
      final session = TrainingSession(
        id: sessionId,
        title: title,
        description: description,
        date: date,
        durationMinutes: durationMinutes,
        location: location,
        objectives: objectives,
        exercises: exercises,
        coachNotes: coachNotes,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('training_sessions')
          .doc(sessionId)
          .set(session.toJson());

      return true;
    } catch (e) {
      print('خطأ في إضافة الجلسة: $e');
      return false;
    }
  }

  // الحصول على جميع الجلسات
  Future<List<TrainingSession>> getTrainingSessions(String coachId) async {
    try {
      final querySnapshot = await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('training_sessions')
          .orderBy('date', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) => TrainingSession.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('خطأ في جلب الجلسات: $e');
      return [];
    }
  }

  // الحصول على الجلسات القادمة فقط
  Future<List<TrainingSession>> getUpcomingTrainingSessions(
      String coachId) async {
    try {
      final querySnapshot = await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('training_sessions')
          .where('date', isGreaterThan: DateTime.now())
          .orderBy('date')
          .get();

      return querySnapshot.docs
          .map((doc) => TrainingSession.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('خطأ في جلب الجلسات القادمة: $e');
      return [];
    }
  }

  // حذف جلسة تدريبية
  Future<bool> deleteTrainingSession({
    required String coachId,
    required String sessionId,
  }) async {
    try {
      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('training_sessions')
          .doc(sessionId)
          .delete();

      return true;
    } catch (e) {
      print('خطأ في حذف الجلسة: $e');
      return false;
    }
  }
}