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
import 'package:bounce_patient_app/src/modules/wallet/services/impls/transaction_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/impls/wallet_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final GetIt prodDIContainer = GetIt.instance;

void initContainers({required AppConfig appConfig}) async {
  print('Prod DI init....');
  prodDIContainer.registerLazySingleton<AppConfig>(() => appConfig);

  //service
  prodDIContainer.registerLazySingleton<IAuthService>(() => AuthService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IMoodService>(() => MoodService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ITherapistListService>(() => TherapistListService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IBookSessionService>(() => BookSessionService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ISessionListService>(() => SessionListService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ISessionService>(() => SessionService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ISongListService>(() => SongListService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IReviewService>(() => ReviewService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IFeedService>(() => FeedService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IFeedListService>(() => FeedListService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ICommentService>(() => CommentService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ICommentListService>(() => CommentListService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IChatService>(() => ChatService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IChatWebsocketService>(() => SignalRWebsocketService());
  prodDIContainer.registerLazySingleton<ICarePlanService>(() => CarePlanService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IJournalService>(() => JournalService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<ITransactionListService>(() => TransactionListService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<IWalletService>(() => WalletService(api: prodDIContainer<IApi>()));
  prodDIContainer.registerLazySingleton<INotificationService>(() => NotificationService(
        api: prodDIContainer<IApi>(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));

  // external
  prodDIContainer.registerLazySingleton<IApi>(() => DioApiService());
}
