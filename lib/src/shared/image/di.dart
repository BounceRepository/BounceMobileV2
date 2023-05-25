import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/fake_image_service.dart';

void imageControllersInit({
  required bool useFake,
}) {
  if (useFake) {
    diContainer.registerFactory(() => FileController(imageService: FakeImageService()));
  } else {
    diContainer.registerFactory(() => FileController(imageService: diContainer()));
  }
}
