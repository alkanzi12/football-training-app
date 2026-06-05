// نموذج الحضور
class Attendance {
  final String id;
  final String playerId;
  final String trainingSessionId;
  final bool isPresent;
  final String? reason; // إذا لم يكن حاضراً
  final DateTime date;

  Attendance({
    required this.id,
    required this.playerId,
    required this.trainingSessionId,
    required this.isPresent,
    this.reason,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerId': playerId,
      'trainingSessionId': trainingSessionId,
      'isPresent': isPresent,
      'reason': reason,
      'date': date.toIso8601String(),
    };
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      playerId: json['playerId'],
      trainingSessionId: json['trainingSessionId'],
      isPresent: json['isPresent'],
      reason: json['reason'],
      date: DateTime.parse(json['date']),
    );
  }
}