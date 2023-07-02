import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

enum ForgotPasswordConfirmationLoadingState { resend, submit }

class ForgotPasswordConfirmationController extends BaseController {
  final IAuthService _authService;

  ForgotPasswordConfirmationController({required IAuthService authService}) : _authService = authService;

  Future<void> execute({required String token}) async {
    try {
      setBusyForObject(ForgotPasswordConfirmationLoadingState.submit, true);
      await _authService.validateOTP(token: token);
    } finally {
      setBusyForObject(ForgotPasswordConfirmationLoadingState.submit, false);
    }
  }

  Future<void> resendOtp({required String email}) async {
    try {
      setBusyForObject(ForgotPasswordConfirmationLoadingState.resend, true);
      await _authService.forgotPassword(email: email);
    } finally {
      setBusyForObject(ForgotPasswordConfirmationLoadingState.resend, false);
    }
  }
}
