import 'package:bounce_patient_app/src/modules/appointment/di.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/impls/impls.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/interfaces.dart';
import 'package:bounce_patient_app/src/modules/auth/di.dart';
import 'package:bounce_patient_app/src/modules/auth/service/auth_service_impl.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service_impl.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:get_it/get_it.dart';

final diContainer = GetIt.instance;

Future<void> init() async {
  // controllers
  authControllersInit(initFakeService: true);
  appointmentControllersInit(initFakeService: true);
  diContainer.registerLazySingleton(() => ImageController(imageService: diContainer()));

  //service
  diContainer
      .registerLazySingleton<IAuthService>(() => AuthServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ImageService>(() => ImageServiceImpl());
  diContainer.registerLazySingleton<ITherapistListService>(
      () => TherapistListServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ISessionBookingService>(
      () => SessionBookingServiceImpl(api: diContainer()));

  //external
  diContainer.registerLazySingleton<IApi>(() => DioApiServiceImpl());
}
