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

class User {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String? image;
  final Gender? gender;

  User({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    this.image,
    this.gender,
  });

  String get fullName {
    return '$firstName $lastName';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["userId"],
        userName: json['userName'],
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json["email"],
        phone: json["phone"] ?? '',
        dateOfBirth: json["dateOfBirth"] ?? '',
        gender: _getGender(json["gender"]),
        image: json['image'],
      );

  User copyWith({
    int? id,
    String? userName,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? dateOfBirth,
    String? image,
    Gender? gender,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      image: image ?? this.image,
      gender: gender ?? this.gender,
    );
  }
}

Gender _getGender(dynamic json) {
  if (json == GenderType.male.name.toUpperCase()) {
    return Gender(type: GenderType.male);
  }
  return Gender(type: GenderType.female);
}
