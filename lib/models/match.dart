// نموذج المباراة
class Match {
  final String id;
  final String opponentTeam;
  final int ourScore;
  final int theirScore;
  final DateTime matchDate;
  final String location;
  final Map<String, int> playerGoals; // اسم اللاعب : عدد الأهداف
  final String? notes;
  final List<String>? photos; // روابط الصور
  final DateTime createdAt;

  Match({
    required this.id,
    required this.opponentTeam,
    required this.ourScore,
    required this.theirScore,
    required this.matchDate,
    required this.location,
    required this.playerGoals,
    this.notes,
    this.photos,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'opponentTeam': opponentTeam,
      'ourScore': ourScore,
      'theirScore': theirScore,
      'matchDate': matchDate.toIso8601String(),
      'location': location,
      'playerGoals': playerGoals,
      'notes': notes,
      'photos': photos,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      opponentTeam: json['opponentTeam'],
      ourScore: json['ourScore'],
      theirScore: json['theirScore'],
      matchDate: DateTime.parse(json['matchDate']),
      location: json['location'],
      playerGoals: Map<String, int>.from(json['playerGoals']),
      notes: json['notes'],
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // هل انتصرنا؟
  bool get isWin => ourScore > theirScore;

  // هل تعادل؟
  bool get isDraw => ourScore == theirScore;

  // هل خسرنا؟
  bool get isLose => ourScore < theirScore;
}