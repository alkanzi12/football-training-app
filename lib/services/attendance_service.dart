import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/attendance.dart';
import '../models/player_performance.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  const uuid = Uuid();

  // تسجيل حضور لاعب
  Future<bool> markAttendance({
    required String coachId,
    required String trainingSessionId,
    required String playerId,
    required bool isPresent,
    String? reason,
  }) async {
    try {
      final attendanceId = uuid.v4();
      final attendance = Attendance(
        id: attendanceId,
        playerId: playerId,
        trainingSessionId: trainingSessionId,
        isPresent: isPresent,
        reason: reason,
        date: DateTime.now(),
      );

      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('attendance')
          .doc(attendanceId)
          .set(attendance.toJson());

      return true;
    } catch (e) {
      print('خطأ في تسجيل الحضور: $e');
      return false;
    }
  }

  // الحصول على سجل الحضور
  Future<List<Attendance>> getAttendanceRecord({
    required String coachId,
    required String trainingSessionId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('attendance')
          .where('trainingSessionId', isEqualTo: trainingSessionId)
          .get();

      return querySnapshot.docs
          .map((doc) => Attendance.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('خطأ في جلب سجل الحضور: $e');
      return [];
    }
  }

  // تسجيل تقييم الأداء
  Future<bool> ratePlayerPerformance({
    required String coachId,
    required String playerId,
    required String trainingSessionId,
    required int rating,
    String? comments,
    Map<String, dynamic>? stats,
  }) async {
    try {
      final performanceId = uuid.v4();
      final performance = PlayerPerformance(
        id: performanceId,
        playerId: playerId,
        trainingSessionId: trainingSessionId,
        rating: rating,
        comments: comments,
        date: DateTime.now(),
        stats: stats,
      );

      await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('performance')
          .doc(performanceId)
          .set(performance.toJson());

      return true;
    } catch (e) {
      print('خطأ في تسجيل التقييم: $e');
      return false;
    }
  }

  // الحصول على تقييمات اللاعب
  Future<List<PlayerPerformance>> getPlayerPerformanceHistory({
    required String coachId,
    required String playerId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('coaches')
          .doc(coachId)
          .collection('performance')
          .where('playerId', isEqualTo: playerId)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PlayerPerformance.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('خطأ في جلب السجل: $e');
      return [];
    }
  }
}