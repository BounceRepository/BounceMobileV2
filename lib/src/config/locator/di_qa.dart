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

final GetIt qaLocator = GetIt.instance;

void initContainers({required AppConfig appConfig}) async {
  print('QA DI init....');
  qaLocator.registerLazySingleton<AppConfig>(() => appConfig);

  //service
  qaLocator.registerLazySingleton<IAuthService>(() => AuthService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IMoodService>(() => MoodService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ITherapistListService>(() => TherapistListService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IBookSessionService>(() => BookSessionService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ISessionListService>(() => SessionListService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ISessionService>(() => SessionService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ISongListService>(() => SongListService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IReviewService>(() => ReviewService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IFeedService>(() => FeedService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IFeedListService>(() => FeedListService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ICommentService>(() => CommentService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ICommentListService>(() => CommentListService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IChatService>(() => ChatService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IChatWebsocketService>(() => SignalRWebsocketService());
  qaLocator.registerLazySingleton<ICarePlanService>(() => CarePlanService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IJournalService>(() => JournalService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<ITransactionListService>(() => TransactionListService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<IWalletService>(() => WalletService(api: qaLocator<IApi>()));
  qaLocator.registerLazySingleton<INotificationService>(() => NotificationService(
        api: qaLocator<IApi>(),
        firebaseMessagingService: FirebaseMessaging.instance,
      ));
  qaLocator.registerLazySingleton<IFileService>(() => FileService(api: qaLocator<IApi>()));

  // external
  qaLocator.registerLazySingleton<IApi>(() => DioApiService());
}
