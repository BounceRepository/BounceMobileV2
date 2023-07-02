import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

class ResetPasswordController extends BaseController {
  final IAuthService _authService;

  ResetPasswordController({required IAuthService authService}) : _authService = authService;

  Future<void> execute({
    required String email,
    required String newPassword,
  }) async {
    try {
      setBusy(true);
      await _authService.resetPassword(email: email, newPassword: newPassword);
    } finally {
      setBusy(false);
    }
  }
}
