// نموذج التمرين
class Exercise {
  final String id;
  final String name;
  final String description;
  final String category; // تمرير، تسديد، جري، دفاع، إلخ
  final int durationSeconds;
  final String difficulty; // سهل، متوسط، صعب
  final String? videoUrl;
  final String? imageUrl;
  final List<String> benefits; // فوائد التمرين
  final DateTime createdAt;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.durationSeconds,
    required this.difficulty,
    this.videoUrl,
    this.imageUrl,
    required this.benefits,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'durationSeconds': durationSeconds,
      'difficulty': difficulty,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'benefits': benefits,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      durationSeconds: json['durationSeconds'],
      difficulty: json['difficulty'],
      videoUrl: json['videoUrl'],
      imageUrl: json['imageUrl'],
      benefits: List<String>.from(json['benefits']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}