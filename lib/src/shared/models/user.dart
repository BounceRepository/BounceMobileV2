class User {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final Gender? gender;

  User({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["userId"],
        userName: json['userName'],
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json["email"],
        phone: json["phone"] ?? '',
        dateOfBirth: json["dateOfBirth"] ?? '',
        gender: _getGender(json["gender"]),
      );
}

Gender _getGender(dynamic json) {
  if (json == GenderType.male.name.toUpperCase()) {
    return Gender(type: GenderType.male);
  }
  return Gender(type: GenderType.female);
}

enum GenderType {
  male,
  female,
}

class Gender {
  final GenderType type;
  bool isSelected;

  Gender({
    required this.type,
    this.isSelected = false,
  });
}
