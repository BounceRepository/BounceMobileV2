import 'package:bounce_patient_app/src/config/app_config.dart';

class AuthURLs {
  AuthURLs._();

  static const baseURL = APIURLs.baseURL + '/Authentication';

  static const register = '$baseURL/register/user';
  static const login = '$baseURL/PatientLogin';
  static const resetPassword = '$baseURL/ResetPassword';
  static const validateToken = '$baseURL/ValidateToken';
  static const changePassword = '$baseURL/ChangePassword';
  static const verifyEmail = '$baseURL/VerifyEmail';
  static const getVerificationStatus = '$baseURL/EmailConfirmationStatus?email=';
  static const createProfile = APIURLs.baseURL + '/Patient/UpdateBioData';
}
