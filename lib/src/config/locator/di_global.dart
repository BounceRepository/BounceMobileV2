import 'package:bounce_patient_app/src/config/app_config.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password/confirmation/forgot_password_confirmation-controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password/forgot_password_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/forgot_password/reset/reset_password_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in/sign_in_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/confirmation/sign_up_confirmation_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/create_profile/create_profile_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/sign_up_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/modules/care_plan/controllers/care_plan_controller.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/mood_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/modules/reviews/controllers/review_controller.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/payment_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:get_it/get_it.dart';

final GetIt _locator = GetIt.instance;

final locator = _locator<GetIt>();
final baseUrl = locator<AppConfig>().baseUrl;

void initGlobalDI({required GetIt envLocator}) async {
  print('Global DI init....');
  _locator.registerLazySingleton<GetIt>(() => envLocator);

  // controllers
  locator.registerLazySingleton(() => FileController(fileService: locator<IFileService>()));
  locator.registerLazySingleton(() => SignInController(authService: locator<IAuthService>()));
  locator.registerLazySingleton(() => SignUpController(authService: locator<IAuthService>()));
  locator.registerLazySingleton(() => SignUpConfirmationController(authService: locator<IAuthService>()));
  locator.registerLazySingleton(() => ForgotPasswordController(authService: locator<IAuthService>()));
  locator.registerLazySingleton(() => ResetPasswordController(authService: locator<IAuthService>()));
  locator.registerLazySingleton(() => ForgotPasswordConfirmationController(authService: locator<IAuthService>()));
  locator.registerLazySingleton(() => CreateProfileController(
        authService: locator<IAuthService>(),
        fileController: locator<FileController>(),
      ));
  locator.registerLazySingleton(() => MoodController(moodService: locator<IMoodService>()));
  locator.registerLazySingleton(() => NotificationController(notificationService: locator<INotificationService>()));
  locator.registerFactory(() => TherapistListController(therapistListService: locator<ITherapistListService>()));
  locator.registerFactory(() => BookSessionController(sessionBookingService: locator<IBookSessionService>()));
  locator.registerFactory(() => SessionListController(sessionListService: locator<ISessionListService>()));
  locator.registerFactory(() => SessionController(sessionService: locator<ISessionService>()));
  locator.registerFactory(() => SongListController(songListService: locator<ISongListService>()));
  locator.registerFactory(() => TransactionListController(transactionListService: locator<ITransactionListService>()));
  locator.registerFactory(() => WalletController(walletService: locator<IWalletService>()));
  locator.registerFactory(() => PaymentController(paymentService: locator<IPaymentService>()));
  locator.registerFactory(() => JournalController(journalService: locator<IJournalService>()));
  locator.registerFactory(() => CarePlanController(subscriptionService: locator<ICarePlanService>()));
  locator.registerFactory(() => ReviewController(reviewService: locator<IReviewService>()));
  locator.registerFactory(() => MyFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => RelationShipFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => SelfCareFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => WorkEthnicsFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => FamilyFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => SexualityFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => ParentingFeedController(
        feedService: locator<IFeedService>(),
        feedListService: locator<IFeedListService>(),
      ));
  locator.registerFactory(() => ChatController(
        chatService: locator<IChatService>(),
        websocketService: locator<IChatWebsocketService>(),
      ));
}
