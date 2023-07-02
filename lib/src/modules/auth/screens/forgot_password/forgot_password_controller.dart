import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

class ForgotPasswordController extends BaseController {
  final IAuthService _authService;

  ForgotPasswordController({required IAuthService authService}) : _authService = authService;

  Future<void> execute({required String email}) async {
    try {
      setBusy(true);
      await _authService.forgotPassword(email: email);
    } finally {
      setBusy(false);
    }
  }
}
