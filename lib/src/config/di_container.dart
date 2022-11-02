import 'package:bounce_patient_app/src/modules/appointment/di.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/impls/appointment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/impls/impls.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/appointment_list_service.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/interfaces.dart';
import 'package:bounce_patient_app/src/modules/auth/di.dart';
import 'package:bounce_patient_app/src/modules/auth/service/impls/auth_service_impl.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/modules/dashboard/di.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/impls/mood_service_impl.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/modules/notifications/di.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/impls/notification_service_impl.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service_impl.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final diContainer = GetIt.instance;

Future<void> init() async {
  // controllers
  authControllersInit(useFake: false);
  moodControllersInit(useFake: true);
  notificationControllersInit(useFake: true);
  appointmentControllersInit(useFake: true);
  diContainer.registerLazySingleton(() => ImageController(imageService: diContainer()));

  //service
  diContainer
      .registerLazySingleton<IAuthService>(() => AuthServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ImageService>(() => ImageServiceImpl());
  diContainer.registerLazySingleton<ITherapistListService>(
      () => TherapistListServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<IBookAppointmentService>(
      () => BookAppointmentServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<IAppointmentListService>(
      () => AppointmentListServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<INotificationService>(() => NotificationServiceImpl(
        api: diContainer(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));
  diContainer
      .registerLazySingleton<IMoodService>(() => MoodServiceImpl(api: diContainer()));

  //external
  diContainer.registerLazySingleton<IApi>(() => DioApiServiceImpl());
}
