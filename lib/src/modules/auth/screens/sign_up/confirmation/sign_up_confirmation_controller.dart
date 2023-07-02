import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

enum SignUpConfirmationLoadingState { verify, resend }

class SignUpConfirmationController extends BaseController {
  final IAuthService _authService;

  SignUpConfirmationController({required IAuthService authService}) : _authService = authService;

  Future<bool> getVerificationStatus({required String email}) async {
    try {
      setBusyForObject(SignUpConfirmationLoadingState.verify, true);
      return await _authService.getVerificationStatus(email: email);
    } finally {
      setBusyForObject(SignUpConfirmationLoadingState.verify, false);
    }
  }

  Future<void> resendVerificationLink({required String email}) async {
    try {
      setBusyForObject(SignUpConfirmationLoadingState.resend, true);
      await _authService.sendVerificationLink(email: email);
    } finally {
      setBusyForObject(SignUpConfirmationLoadingState.resend, false);
    }
  }
}
