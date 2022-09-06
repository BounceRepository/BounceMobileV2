import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/service/auth_service_impl.dart';
import 'package:bounce_patient_app/src/modules/auth/service/fakes/fake_auth_service_impl.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service_impl.dart';
import 'package:bounce_patient_app/src/shared/network/request_helper.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // controllers
  //serviceLocator.registerFactory(() => AuthController(authService: AuthServiceImpl(requestHelper: serviceLocator())));
  serviceLocator.registerFactory(() => AuthController(authService: FakeAuthServiceImpl()));
  serviceLocator
      .registerLazySingleton(() => ImageController(imageService: serviceLocator()));

  //service
  serviceLocator.registerLazySingleton<ImageService>(() => ImageServiceImpl());

  //external
  serviceLocator.registerLazySingleton<IRequestHelper>(() => DioRequestHelper());
}
