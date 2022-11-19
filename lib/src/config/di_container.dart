import 'package:bounce_patient_app/src/modules/book_session/di.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/impls/session_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/impls/impls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/interfaces.dart';
import 'package:bounce_patient_app/src/modules/auth/di.dart';
import 'package:bounce_patient_app/src/modules/auth/service/impls/auth_service_impl.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/modules/dashboard/di.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/impls/mood_service_impl.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/modules/journal/services/di.dart';
import 'package:bounce_patient_app/src/modules/notifications/di.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/impls/notification_service_impl.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/modules/playlist/di.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/impls/song_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/di.dart';
import 'package:bounce_patient_app/src/modules/wallet/di.dart';
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
  appointmentControllersInit(useFake: false);
  playListControllersInit(useFake: true);
  walletControllersInit(useFake: false);
  journalControllersInit(useFake: true);
  subscriptionControllersInit(useFake: false);
  diContainer.registerLazySingleton(() => ImageController(imageService: diContainer()));

  //service
  walletServicesInit();
  journalServicesInit();
  subscriptionServicesInit();
  diContainer
      .registerLazySingleton<IAuthService>(() => AuthServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ImageService>(() => ImageServiceImpl());
  diContainer.registerLazySingleton<ITherapistListService>(
      () => TherapistListServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<IBookAppointmentService>(
      () => SessionServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ISessionListService>(
      () => SessionListServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ISongListService>(
      () => SongListServiceImpl(api: diContainer()));

  diContainer.registerLazySingleton<INotificationService>(() => NotificationServiceImpl(
        api: diContainer(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));
  diContainer
      .registerLazySingleton<IMoodService>(() => MoodServiceImpl(api: diContainer()));

  //external
  diContainer.registerLazySingleton<IApi>(() => DioApiServiceImpl());
}
