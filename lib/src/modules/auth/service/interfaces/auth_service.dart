import 'dart:io';

import 'package:bounce_patient_app/src/shared/models/user.dart';

abstract class IAuthService {
  Future<int> register({
    required String userName,
    required String email,
    required String password,
  });
  Future<void> login({
    required String userName,
    required String password,
  });
  Future<void> resetPassword({
    required String email,
  });
  Future<void> validateOTP({
    required String token,
  });
  Future<void> changePassword({
    required String email,
    required String newPassword,
  });
  Future<void> sendVerificationLink({required String email});
  Future<bool> getVerificationStatus({required String email});
  Future<void> createProfile({
    required int userId,
    required Gender gender,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required File image,
    required String dateOfBirth,
    required String physicalHealtRate,
    required String mentalHealtRate,
    required String emotionalHealtRate,
    required String eatingHabit,
  });
}
