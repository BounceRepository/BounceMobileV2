import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';

class AuthController extends BaseController {
  final IAuthService _authService;

  AuthController({required IAuthService authService}) : _authService = authService;

  String? email;
  int? userId;
  Gender? gender;

  Future<void> signIn({
    required String userName,
    required String password,
  }) async {
    try {
      setIsLoading(true);
      await _authService.login(
        email: userName,
        password: password,
      );
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  bool _isSendingOTP = false;
  bool get isSendingOTP => _isSendingOTP;
  void setIsSendingOTP(bool value) {
    _isSendingOTP = value;
    notifyListeners();
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      setIsSendingOTP(true);
      await _authService.resetPassword(email: email);
      setIsSendingOTP(false);
    } on Failure {
      setIsSendingOTP(false);
      rethrow;
    }
  }

  Future<void> validateOTP({required String token}) async {
    try {
      setIsLoading(true);
      await _authService.validateOTP(token: token);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> changePassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      setIsLoading(true);
      await _authService.changePassword(
        email: email,
        newPassword: newPassword,
      );
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<int> createAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      setIsLoading(true);
      final userId = await _authService.register(
        userName: userName,
        email: email,
        password: password,
      );
      setIsLoading(false);
      return userId;
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> verifyEmail({required String email}) async {
    try {
      setIsLoading(true);
      await _authService.sendVerificationLink(email: email);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<bool> getVerificationStatus({required String email}) async {
    try {
      setIsLoading(true);
      final status = await _authService.getVerificationStatus(email: email);
      setIsLoading(false);
      return status;
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> createProfile({
    required int userId,
    required Gender gender,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String userName,
    File? image,
    required String dateOfBirth,
    required String physicalHealtRate,
    required String mentalHealtRate,
    required String emotionalHealtRate,
    required String eatingHabit,
    required String email,
  }) async {
    try {
      setIsLoading(true);
      await _authService.createProfile(
        userId: userId,
        gender: gender,
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        phoneNumber: phoneNumber,
        image: image,
        dateOfBirth: dateOfBirth,
        physicalHealtRate: physicalHealtRate,
        mentalHealtRate: mentalHealtRate,
        emotionalHealtRate: emotionalHealtRate,
        eatingHabit: eatingHabit,
        email: email,
      );
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
