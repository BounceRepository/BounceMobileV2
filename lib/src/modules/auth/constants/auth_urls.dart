import 'package:bounce_patient_app/src/config/app_config.dart';

class AuthURLs {
  AuthURLs._();

  static String baseURL = '${APIURLs.baseURL}/Authentication';

  static String register = '$baseURL/register/user';
  static String login = '$baseURL/PatientLogin';
  static String resetPassword = '$baseURL/ResetPassword';
  static String validateToken = '$baseURL/ValidateToken';
  static String changePassword = '$baseURL/ChangePassword';
  static String verifyEmail = '$baseURL/VerifyEmail';
  static String getVerificationStatus = '$baseURL/EmailConfirmationStatus?email=';
  static String createProfile = '${APIURLs.baseURL}/Patient/UpdateBioData';
}
