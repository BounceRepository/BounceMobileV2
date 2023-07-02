import 'package:bounce_patient_app/src/config/app_config.dart';
import 'package:bounce_patient_app/src/modules/auth/service/fakes/fake_auth_service_impl.dart';
import 'package:bounce_patient_app/src/modules/auth/service/interfaces/i_auth_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/fakes/fake_care_plan_service_impl.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/fakes/fake_chat_service_impl.dart';
import 'package:bounce_patient_app/src/modules/chat/services/fakes/fake_chat_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/fakes/fake_mood_service.dart';
import 'package:bounce_patient_app/src/modules/dashboard/services/interfaces/mood_service.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/modules/journal/services/fakes/fake_journal_service_impl.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/fakes/fake_notification_service_impl.dart';
import 'package:bounce_patient_app/src/modules/notifications/services/interfaces/notification_service.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/fakes/fake_song_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/playlist/services/interfaces/song_list_service.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/fakes/fake_review_service_impl.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_payment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_transaction_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/fakes/fake_wallet_service_impl.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/payment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/transaction_list_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/services/interfaces/wallet_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/fake_image_service.dart';
import 'package:bounce_patient_app/src/shared/image/service/i_image_service.dart';
import 'package:get_it/get_it.dart';

final GetIt devLocator = GetIt.instance;

void initContainers({required AppConfig appConfig}) async {
  print('Dev DI init....');
  devLocator.registerLazySingleton<AppConfig>(() => appConfig);

  //service
  devLocator.registerLazySingleton<IAuthService>(() => FakeAuthService());
  devLocator.registerLazySingleton<IMoodService>(() => FakeMoodService());
  devLocator.registerLazySingleton<ISongListService>(() => FakeSongListService());
  devLocator.registerLazySingleton<ITherapistListService>(() => FakeTherapistListService());
  devLocator.registerLazySingleton<IBookSessionService>(() => FakeBookAppointmentService());
  devLocator.registerLazySingleton<ISessionListService>(() => FakeSessionListService());
  devLocator.registerLazySingleton<ISessionService>(() => FakeSessionService());
  devLocator.registerLazySingleton<INotificationService>(() => FakeNotificationService());
  devLocator.registerLazySingleton<ITransactionListService>(() => FakeTransactionListService());
  devLocator.registerLazySingleton<IWalletService>(() => FakeWalletService());
  devLocator.registerLazySingleton<IPaymentService>(() => FakePaymentService());
  devLocator.registerLazySingleton<IJournalService>(() => FakeJournalService());
  devLocator.registerLazySingleton<ICarePlanService>(() => FakeCarePlanService());
  devLocator.registerLazySingleton<IChatService>(() => FakeChatService());
  devLocator.registerLazySingleton<IChatWebsocketService>(() => FakeChatWebsocketService());
  devLocator.registerLazySingleton<IFeedService>(() => FakeFeedService());
  devLocator.registerLazySingleton<IFeedListService>(() => FakeFeedListService());
  devLocator.registerLazySingleton<IReviewService>(() => FakeReviewService());
  devLocator.registerLazySingleton<IFileService>(() => FakeFileService());
}
