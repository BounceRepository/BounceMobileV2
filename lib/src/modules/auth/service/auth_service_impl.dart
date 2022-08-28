import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/constants/auth_urls.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/network/request_helper.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> changePassword({
    required String email,
    required String newPassword,
  }) async {
    var url = AuthURLs.changePassword;
    var body = {'email': email, 'password': newPassword};

    try {
      await HttpRequestHelper.postRequest(url, body);
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
      await HttpRequestHelper.postRequest(url, body);
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
      final response = await HttpRequestHelper.postRequest(url, body);
      return response['data']['userId'];
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    var url = AuthURLs.resetPassword;
    var body = {
      "email": email,
    };

    try {
      await HttpRequestHelper.postRequest(url, body);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> validateOTP({required String token}) async {
    var url = AuthURLs.validateToken;
    var body = {
      "token": token,
    };

    try {
      await HttpRequestHelper.postRequest(url, body);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<bool> getVerificationStatus({required String email}) async {
    var url = AuthURLs.getVerificationStatus + email;
    try {
      final response = await HttpRequestHelper.getRequest(url);
      return response['data'];
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> sendVerificationLink({required String email}) async {
    var url = AuthURLs.verifyEmail;
    var body = {'email': email};
    try {
      await HttpRequestHelper.postRequest(url, body);
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
    var body = {
      'DateOfBirth': DateTimeHelperFunctions.getDate(dateOfBirth).toIso8601String(),
      'FirstName': firstName,
      'LastName': lastName,
      'Phone': phoneNumber,
      'UserId': userId,
      'Gender': gender.type.name.toString(),
      'File': HelperFunctions.convertToBytes(image),
    };
    try {
      await HttpRequestHelper.postRequest(url, body);
    } on Failure {
      rethrow;
    }
  }
}
