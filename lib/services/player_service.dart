import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/player.dart';

class PlayerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  const uuid = Uuid();

  // إضافة لاعب جديد
  Future<bool> addPlayer({
    required String coachId,
    required String name,
    required int number,
    required String position,
    required DateTime dateOfBirth,
    double? height,
    double? weight,
    String? phoneNumber,
  }) async {
    try {
      final playerId = uuid.v4();
      final player = Player(
        id: playerId,
        name: name,
        number: number,
        position: position,
        dateOfBirth: dateOfBirth,
        height: height,
        weight: weight,
        phoneNumber: phoneNumber,
        dateJoined: DateTime.now(),
      );

      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('players')
          .doc(playerId)
          .set(player.toJson());

      return true;
    } catch (e) {
      print('خطأ في إضافة لاعب: $e');
      return false;
    }
  }

  // الحصول على جميع اللاعبين
  Future<List<Player>> getPlayers(String coachId) async {
    try {
      final querySnapshot = await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('players')
          .get();

      return querySnapshot.docs
          .map((doc) => Player.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('خطأ في جلب اللاعبين: $e');
      return [];
    }
  }

  // تحديث بيانات لاعب
  Future<bool> updatePlayer({
    required String coachId,
    required String playerId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('players')
          .doc(playerId)
          .update(data);

      return true;
    } catch (e) {
      print('خطأ في تحديث البيانات: $e');
      return false;
    }
  }

  // حذف لاعب
  Future<bool> deletePlayer({
    required String coachId,
    required String playerId,
  }) async {
    try {
      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('players')
          .doc(playerId)
          .delete();

      return true;
    } catch (e) {
      print('خطأ في حذف اللاعب: $e');
      return false;
    }
  }
}