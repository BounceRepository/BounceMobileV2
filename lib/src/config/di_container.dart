import 'package:bounce_patient_app/src/modules/auth/di.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service_impl.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:get_it/get_it.dart';

final diContainer = GetIt.instance;

Future<void> init() async {
  // controllers
  authServiceInit(initFakeService: false);
  diContainer.registerLazySingleton(() => ImageController(imageService: diContainer()));

  //service
  diContainer.registerLazySingleton<ImageService>(() => ImageServiceImpl());

  //external
  diContainer.registerLazySingleton<IApi>(() => DioApiServiceImpl());
}
