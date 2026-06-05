// نموذج اللاعب
class Player {
  final String id;
  final String name;
  final int number;
  final String position; // حارس، دفاع، وسط، هجوم
  final DateTime dateOfBirth;
  final double? height;
  final double? weight;
  final String? phoneNumber;
  final DateTime dateJoined;

  Player({
    required this.id,
    required this.name,
    required this.number,
    required this.position,
    required this.dateOfBirth,
    this.height,
    this.weight,
    this.phoneNumber,
    required this.dateJoined,
  });

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'position': position,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'height': height,
      'weight': weight,
      'phoneNumber': phoneNumber,
      'dateJoined': dateJoined.toIso8601String(),
    };
  }

  // من JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      position: json['position'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      height: json['height'],
      weight: json['weight'],
      phoneNumber: json['phoneNumber'],
      dateJoined: DateTime.parse(json['dateJoined']),
    );
  }

  // حساب العمر
  int getAge() {
    return DateTime.now().year - dateOfBirth.year;
  }
}