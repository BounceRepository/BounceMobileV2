import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/constants/auth_urls.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:dio/dio.dart';

class AuthServiceImpl implements IAuthService {
  final IApi _api;

  AuthServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> changePassword({
    required String email,
    required String newPassword,
  }) async {
    var url = AuthURLs.changePassword;
    var body = {'email': email, 'password': newPassword};

    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> login({
    required String userName,
    required String password,
  }) async {
    var url = AuthURLs.login;
    var body = {'username': userName, 'password': password};

    try {
      final response = await _api.post(url, body: body);
      final data = response['data'];
      DataStore.authToken = data['token'];
      DataStore.user = User.fromJson(data);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<int> register({
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
      return response['data']['userId'];
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    var url = AuthURLs.resetPassword + '?email=$email';
    var body = {};

    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> validateOTP({required String token}) async {
    var url = AuthURLs.validateToken + '?token=$token';
    var body = {};

    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
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
    }
  }

  @override
  Future<void> sendVerificationLink({required String email}) async {
    var url = AuthURLs.verifyEmail + '?email=$email';
    var body = {};
    try {
      await _api.post(url, body: body);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> createProfile({
    required int userId,
    required Gender gender,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required File image,
    required String dateOfBirth,
  }) async {
    var url = AuthURLs.createProfile;
    String fileName = image.path.split('/').last;

    var body = {
      'DateOfBirth': DateTimeHelperFunctions.getDate(dateOfBirth).toIso8601String(),
      'FirstName': firstName,
      'LastName': lastName,
      'Phone': '0$phoneNumber',
      'UserId': userId,
      'Gender': gender.type.name.toString().toUpperCase(),
      'ImageFile': await MultipartFile.fromFile(image.path, filename: fileName),
      'MeansOfIdentification':
          await MultipartFile.fromFile(image.path, filename: fileName)
    };
    var formData = FormData.fromMap(body);

    try {
      await _api.post(url, body: formData, isFormData: true);
    } on Failure {
      rethrow;
    }
  }
}
