import 'package:bounce_patient_app/src/config/app_config.dart';
import 'package:bounce_patient_app/src/modules/auth/service/impls/auth_service.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
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
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/image_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';
import 'package:bounce_patient_app/src/shared/network/dio_api_service_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final GetIt prodLocator = GetIt.instance;

void initContainers({required AppConfig appConfig}) async {
  print('Prod DI init....');
  prodLocator.registerLazySingleton<AppConfig>(() => appConfig);

  //service
  prodLocator.registerLazySingleton<IAuthService>(() => AuthService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IMoodService>(() => MoodService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ITherapistListService>(() => TherapistListService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IBookSessionService>(() => BookSessionService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ISessionListService>(() => SessionListService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ISessionService>(() => SessionService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ISongListService>(() => SongListService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IReviewService>(() => ReviewService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IFeedService>(() => FeedService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IFeedListService>(() => FeedListService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ICommentService>(() => CommentService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ICommentListService>(() => CommentListService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IChatService>(() => ChatService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IChatWebsocketService>(() => SignalRWebsocketService());
  prodLocator.registerLazySingleton<ICarePlanService>(() => CarePlanService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IJournalService>(() => JournalService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<ITransactionListService>(() => TransactionListService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<IWalletService>(() => WalletService(api: prodLocator<IApi>()));
  prodLocator.registerLazySingleton<INotificationService>(() => NotificationService(
        api: prodLocator<IApi>(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));
  prodLocator.registerLazySingleton<IFileService>(() => FileService(api: prodLocator<IApi>()));

  // external
  prodLocator.registerLazySingleton<IApi>(() => DioApiService());
}
