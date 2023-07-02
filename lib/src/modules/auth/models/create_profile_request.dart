import 'dart:io';

import 'package:bounce_patient_app/src/shared/models/user.dart';

class CreateProfileRequest {
  final int userId;
  final Gender gender;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userName;
  final File? image;
  final String dateOfBirth;
  final String physicalHealtRate;
  final String mentalHealtRate;
  final String emotionalHealtRate;
  final String eatingHabit;
  final String email;

  CreateProfileRequest({
    required this.userId,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userName,
    required this.dateOfBirth,
    required this.physicalHealtRate,
    required this.mentalHealtRate,
    required this.emotionalHealtRate,
    required this.eatingHabit,
    required this.email,
    this.image,
  });
}
