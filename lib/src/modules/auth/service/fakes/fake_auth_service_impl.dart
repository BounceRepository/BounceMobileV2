import 'dart:developer';

import 'package:bounce_patient_app/src/local/local_storage_service.dart';
import 'package:bounce_patient_app/src/modules/auth/models/create_profile_request.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeAuthService implements IAuthService {
  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await fakeNetworkDelay();
    // TODO: implement createProfile
    //throw InternalFailure();
  }

  @override
  Future<bool> getVerificationStatus({required String email}) async {
    await fakeNetworkDelay();
    return true;
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await fakeNetworkDelay();
    AppSession.user = User(
      id: 10,
      firstName: 'Vincent',
      lastName: 'Appleyard',
      userName: 'applevinc',
      email: 'appleyard@gmail.com',
      phone: '07017247035',
      dateOfBirth: '1990-02-08',
    );
    _saveDetailsToLocalStorage(email: 'appleyard@gmail.com', userName: 'applevinc');

    //throw InCompleteProfileFailure();
    //throw ConfirmEmailFailure();
    //throw InternalFailure();
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
    await fakeNetworkDelay();
    //throw InternalFailure();
    return 10;
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
  }

  @override
  Future<void> validateOTP({required String token}) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
  }

  @override
  Future<void> sendVerificationLink({required String email}) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
  }

  @override
  Future<void> createProfile(CreateProfileRequest request) async {
    await fakeNetworkDelay();
    final user = User(
      id: request.userId,
      userName: request.userName,
      firstName: request.firstName,
      lastName: request.lastName,
      email: request.email,
      phone: request.phoneNumber,
      dateOfBirth: request.dateOfBirth,
    );
    AppSession.user = user;
    //throw InternalFailure();
  }
}
