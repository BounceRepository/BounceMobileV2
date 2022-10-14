import 'dart:io';

import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/shared/models/datastore.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';

class FakeAuthServiceImpl implements AuthService {
  final delay = const Duration(seconds: 2);

  @override
  Future<void> changePassword({
    required String email,
    required String newPassword,
  }) async {
    await Future.delayed(delay);
    // TODO: implement createProfile
    throw UnimplementedError();
  }

  @override
  Future<bool> getVerificationStatus({required String email}) async {
    await Future.delayed(delay);
    return true;
  }

  @override
  Future<void> login({
    required String userName,
    required String password,
  }) async {
    await Future.delayed(delay);
    DataStore.user = User(
      id: 10,
      firstName: 'Test',
      lastName: 'TestLast',
      userName: 'TestName',
      email: 'test@gmail.com',
      phone: '07030000121',
      dateOfBirth: '1990-02-08',
    );
  }

  @override
  Future<int> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(delay);
    return 10;
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await Future.delayed(delay);
    // TODO: implement createProfile
    throw UnimplementedError();
  }

  @override
  Future<void> validateOTP({required String token}) async {
    await Future.delayed(delay);
    // TODO: implement createProfile
    throw UnimplementedError();
  }

  @override
  Future<void> sendVerificationLink({required String email}) async {
    await Future.delayed(delay);
    // TODO: implement createProfile
    throw UnimplementedError();
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
    await Future.delayed(delay);

    // // TODO: implement createProfile
    // throw UnimplementedError();
  }
}
