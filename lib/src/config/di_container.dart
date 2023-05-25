import 'package:bounce_patient_app/src/modules/book_session/di.dart';
import 'package:bounce_patient_app/src/modules/auth/di.dart';
import 'package:bounce_patient_app/src/modules/auth/service/impls/auth_service.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/di.dart';
import 'package:bounce_patient_app/src/modules/dashboard/di.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/impls/mood_service_impl.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/modules/feed/services/di.dart';
import 'package:bounce_patient_app/src/modules/journal/services/di.dart';
import 'package:bounce_patient_app/src/modules/notifications/di.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/impls/notification_service_impl.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/modules/playlist/di.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/impls/song_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/di.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/di.dart';
import 'package:bounce_patient_app/src/modules/wallet/di.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final diContainer = GetIt.instance;

Future<void> init() async {
  bool useFake = false;

  // controllers
  authControllersInit(useFake: useFake);
  moodControllersInit(useFake: true);
  notificationControllersInit(useFake: useFake);
  appointmentControllersInit(useFake: useFake);
  playListControllersInit(useFake: true);
  walletControllersInit(useFake: useFake);
  journalControllersInit(useFake: useFake);
  subscriptionControllersInit(useFake: useFake);
  chatControllersInit(useFake: useFake);
  feedControllersInit(useFake: useFake);
  reviewControllersInit(useFake: useFake);
  diContainer.registerLazySingleton(() => FileController(imageService: diContainer()));

  //service
  walletServicesInit();
  journalServicesInit();
  subscriptionServicesInit();
  chatServicesInit();
  feedServicesInit();
  reviewServicesInit();
  appointmentServicesInit();
  diContainer.registerLazySingleton<IAuthService>(() => AuthService(api: diContainer()));
  diContainer.registerLazySingleton<IFileService>(() => FileService(api: diContainer()));
  diContainer.registerLazySingleton<ISongListService>(() => SongListService(api: diContainer()));

  diContainer.registerLazySingleton<INotificationService>(() => NotificationService(
        api: diContainer(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));
  diContainer.registerLazySingleton<IMoodService>(() => MoodService(api: diContainer()));

  //external
  diContainer.registerLazySingleton<IApi>(() => DioApiService());
}
