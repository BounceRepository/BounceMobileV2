import 'package:bounce_patient_app/src/config/app_config.dart';
import 'package:bounce_patient_app/src/modules/auth/service/impls/auth_service.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/auth_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/impls/session_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/impls/session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/impls/care_plan_service_impl.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/impls/chat_service_impl.dart';
import 'package:bounce_patient_app/src/modules/chat/services/impls/signal_r_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/impls/mood_service_impl.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/comment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/comment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/feed_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/feed_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/modules/journal/services/impls/journal_service_impl.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/impls/notification_service_impl.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/impls/song_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/impls/review_service_impl.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final GetIt qaDIContainer = GetIt.instance;

void initContainers({required AppConfig appConfig}) async {
  print('QA DI init....');
  qaDIContainer.registerLazySingleton<AppConfig>(() => appConfig);

  //service
  qaDIContainer.registerLazySingleton<IAuthService>(() => AuthService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IMoodService>(() => MoodService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<ITherapistListService>(() => TherapistListService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IBookSessionService>(() => BookSessionService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<ISessionListService>(() => SessionListService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<ISessionService>(() => SessionService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<ISongListService>(() => SongListService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IReviewService>(() => ReviewService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IFeedService>(() => FeedService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IFeedListService>(() => FeedListService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<ICommentService>(() => CommentService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<ICommentListService>(() => CommentListService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IChatService>(() => ChatService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IChatWebsocketService>(() => SignalRWebsocketService());
  qaDIContainer.registerLazySingleton<ICarePlanService>(() => CarePlanService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<IJournalService>(() => JournalService(api: qaDIContainer<IApi>()));
  qaDIContainer.registerLazySingleton<INotificationService>(() => NotificationService(
        api: qaDIContainer<IApi>(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));

  // external
  qaDIContainer.registerLazySingleton<IApi>(() => DioApiService());
}
