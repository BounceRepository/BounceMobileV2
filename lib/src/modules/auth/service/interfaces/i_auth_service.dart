import 'package:bounce_patient_app/src/modules/auth/models/create_profile_request.dart';

abstract class IAuthService {
  Future<int> signUp({
    required String userName,
    required String email,
    required String password,
  });
  Future<void> signIn({
    required String email,
    required String password,
  });
  Future<void> forgotPassword({
    required String email,
  });
  Future<void> validateOTP({
    required String token,
  });
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });
  Future<void> sendVerificationLink({required String email});
  Future<bool> getVerificationStatus({required String email});
  Future<void> createProfile(CreateProfileRequest request);
}
