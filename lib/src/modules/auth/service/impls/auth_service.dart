import 'dart:developer';

import 'package:bounce_patient_app/src/local/local_storage_service.dart';
import 'package:bounce_patient_app/src/modules/auth/constants/auth_urls.dart';
import 'package:bounce_patient_app/src/modules/auth/models/create_profile_request.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:dio/dio.dart';

class AuthService implements IAuthService {
  final IApi _api;

  AuthService({required IApi api}) : _api = api;

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    var url = AuthURLs.changePassword;
    var body = {'email': email, 'password': newPassword};

    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    var url = AuthURLs.login;
    var body = {'username': email, 'password': password};

    try {
      final response = await _api.post(url, body: body);
      final data = response['data'];
      AppSession.authToken = data['token'];
      AppSession.user = User.fromJson(data);
      _saveDetailsToLocalStorage(email: email, userName: data['userName']);

      if (data['confirmedEmail'] == false) {
        throw ConfirmEmailFailure();
      }

      if (data['hasProfile'] == false) {
        throw InCompleteProfileFailure();
      }
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  void _saveDetailsToLocalStorage({
    required String email,
    required String userName,
  }) async {
    try {
      await LocalStorageService.saveLoginDetails(
        email: email,
        userName: userName,
      );
    } on Failure catch (e) {
      log(e.message);
    }
  }

  @override
  Future<int> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    var url = AuthURLs.register;
    var body = {
      "username": userName,
      "email": email,
      "password": password,
    };

    try {
      final response = await _api.post(url, body: body);
      AppSession.authToken = response['data']['token'];
      return response['data']['userId'];
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    var url = '${AuthURLs.resetPassword}?email=$email';
    var body = {};

    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> validateOTP({required String token}) async {
    var url = '${AuthURLs.validateToken}?token=$token';
    var body = {};

    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<bool> getVerificationStatus({required String email}) async {
    var url = AuthURLs.getVerificationStatus + email;
    try {
      final response = await _api.get(url);
      return response['data'];
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> sendVerificationLink({required String email}) async {
    var url = '${AuthURLs.verifyEmail}?email=$email';
    var body = {};
    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> createProfile(CreateProfileRequest request) async {
    var url = AuthURLs.createProfile;
    Map<String, dynamic> body = {};
    FormData formData;

    final image = request.image;
    if (image != null) {
      String fileName = image.path.split('/').last;
      body = {
        'DateOfBirth': DateTimeUtils.getDate(request.dateOfBirth).toIso8601String(),
        'FirstName': request.firstName,
        'LastName': request.lastName,
        'Phone': request.phoneNumber,
        'UserId': request.userId,
        'Gender': request.gender.type.name.toString().toUpperCase(),
        'PhysicalHealthRate': request.physicalHealtRate,
        'MentalHealthRate': request.mentalHealtRate,
        'EmotionalHealthRate': request.emotionalHealtRate,
        'EatingHabit': request.eatingHabit,
        'Email': request.email,
        'ImageFile': await MultipartFile.fromFile(image.path, filename: fileName),
        'MeansOfIdentification': await MultipartFile.fromFile(image.path, filename: fileName)
      };

      formData = FormData.fromMap(body);
    } else {
      body = {
        'DateOfBirth': DateTimeUtils.getDate(request.dateOfBirth).toIso8601String(),
        'FirstName': request.firstName,
        'LastName': request.lastName,
        'Phone': request.phoneNumber,
        'UserId': request.userId,
        'Gender': request.gender.type.name.toString().toUpperCase(),
        'PhysicalHealthRate': request.physicalHealtRate,
        'MentalHealthRate': request.mentalHealtRate,
        'EmotionalHealthRate': request.emotionalHealtRate,
        'EatingHabit': request.eatingHabit,
        'Email': request.email,
      };
      formData = FormData.fromMap(body);
    }

    try {
      final response = await _api.patch(url, body: formData, isFormData: true);
      final data = response['data'];
      final user = User(
        id: request.userId,
        userName: request.userName,
        firstName: request.firstName,
        lastName: request.lastName,
        email: request.email,
        phone: request.phoneNumber,
        dateOfBirth: request.dateOfBirth,
        image: data['image'],
      );
      AppSession.user = user;
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
