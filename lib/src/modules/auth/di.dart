import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/service/fakes/fake_auth_service_impl.dart';

void authControllersInit({
  required bool initFakeService,
}) {
  if (initFakeService) {
    diContainer.registerFactory(() => AuthController(authService: FakeAuthServiceImpl()));
  } else {
    diContainer.registerFactory(() => AuthController(authService: diContainer()));
  }
}
