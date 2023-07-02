import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

enum SignInLoadingState { verifyEmail }

class SignInController extends BaseController {
  final IAuthService _authService;

  SignInController({required IAuthService authService}) : _authService = authService;

  Future<void> execute({
    required String username,
    required String password,
  }) async {
    try {
      setBusy(true);
      await _authService.signIn(email: username, password: password);
    } finally {
      setBusy(false);
    }
  }

  Future<void> verifyEmail({required String email}) async {
    try {
      setBusyForObject(SignInLoadingState.verifyEmail, true);
      await _authService.sendVerificationLink(email: email);
    } finally {
      setBusyForObject(SignInLoadingState.verifyEmail, false);
    }
  }
}
