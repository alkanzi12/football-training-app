// نموذج تقييم الأداء
class PlayerPerformance {
  final String id;
  final String playerId;
  final String trainingSessionId;
  final int rating; // من 1 إلى 10
  final String? comments;
  final DateTime date;
  final Map<String, dynamic>? stats; // إحصائيات إضافية

  PlayerPerformance({
    required this.id,
    required this.playerId,
    required this.trainingSessionId,
    required this.rating,
    this.comments,
    required this.date,
    this.stats,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerId': playerId,
      'trainingSessionId': trainingSessionId,
      'rating': rating,
      'comments': comments,
      'date': date.toIso8601String(),
      'stats': stats,
    };
  }

  factory PlayerPerformance.fromJson(Map<String, dynamic> json) {
    return PlayerPerformance(
      id: json['id'],
      playerId: json['playerId'],
      trainingSessionId: json['trainingSessionId'],
      rating: json['rating'],
      comments: json['comments'],
      date: DateTime.parse(json['date']),
      stats: json['stats'],
    );
  }
}