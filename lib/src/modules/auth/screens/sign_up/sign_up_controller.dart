import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class SignUpController extends BaseController {
  final IAuthService _authService;

  SignUpController({required IAuthService authService}) : _authService = authService;

  int? _userId;
  int? get userId => _userId;

  bool _hasAcceptedTC = false;
  bool get hasAcceptedTC => _hasAcceptedTC;

  void updatedTCAgreement(bool value) {
    _hasAcceptedTC = value;
    notifyListeners();
  }

  Future<void> execute({
    required String username,
    required String email,
    required String password,
  }) async {
    if (hasAcceptedTC == false) throw Failure('You need to agree to Thrivex terms and conditions to proceed');

    try {
      setBusy(true);
      _userId = await _authService.signUp(
        userName: username,
        email: email,
        password: password,
      );
    } finally {
      setBusy(false);
    }
  }
}
