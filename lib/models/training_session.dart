// نموذج جلسة التدريب
class TrainingSession {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final int durationMinutes;
  final String location;
  final List<String> objectives; // أهداف التدريب
  final List<String> exercises; // التمارين
  final String? coachNotes;
  final DateTime createdAt;

  TrainingSession({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.durationMinutes,
    required this.location,
    required this.objectives,
    required this.exercises,
    this.coachNotes,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'durationMinutes': durationMinutes,
      'location': location,
      'objectives': objectives,
      'exercises': exercises,
      'coachNotes': coachNotes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      durationMinutes: json['durationMinutes'],
      location: json['location'],
      objectives: List<String>.from(json['objectives']),
      exercises: List<String>.from(json['exercises']),
      coachNotes: json['coachNotes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}