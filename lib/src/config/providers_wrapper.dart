import 'package:bounce_patient_app/src/config/locator/di_global.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/book_session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/gender_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/health_level_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/call_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/mood_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/navbar_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/reviews/controllers/review_controller.dart';
import 'package:bounce_patient_app/src/modules/care_plan/controllers/care_plan_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/payment_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/wallet_controller.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/feed/controllers/controllers.dart';

class ProvidersWrapper extends StatelessWidget {
  const ProvidersWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<AuthController>()),
        ChangeNotifierProvider(create: (_) => locator<FileController>()),
        ChangeNotifierProvider(create: (_) => locator<TherapistListController>()),
        ChangeNotifierProvider(create: (_) => locator<BookSessionController>()),
        ChangeNotifierProvider(create: (_) => locator<SessionListController>()),
        ChangeNotifierProvider(create: (_) => locator<MoodController>()),
        ChangeNotifierProvider(create: (_) => locator<NotificationController>()),
        ChangeNotifierProvider(create: (_) => locator<SongListController>()),
        ChangeNotifierProvider(create: (_) => locator<TransactionListController>()),
        ChangeNotifierProvider(create: (_) => locator<WalletController>()),
        ChangeNotifierProvider(create: (_) => locator<JournalController>()),
        ChangeNotifierProvider(create: (_) => locator<CarePlanController>()),
        ChangeNotifierProvider(create: (_) => locator<ChatController>()),
        ChangeNotifierProvider(create: (_) => locator<FeedController>()),
        ChangeNotifierProvider(create: (_) => locator<MyFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<RelationShipFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<SelfCareFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<WorkEthnicsFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<FamilyFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<SexualityFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<ParentingFeedController>()),
        ChangeNotifierProvider(create: (_) => locator<CommentController>()),
        ChangeNotifierProvider(create: (_) => locator<MyCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<RelationShipCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<SelfCareCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<WorkEthnicsCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<FamilyCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<SexualityCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<ParentingCommentController>()),
        ChangeNotifierProvider(create: (_) => locator<ReviewController>()),
        ChangeNotifierProvider(create: (_) => locator<PaymentController>()),
        ChangeNotifierProvider(create: (_) => locator<SessionController>()),
        ChangeNotifierProvider(create: (_) => HealthLevelController()),
        ChangeNotifierProvider(create: (_) => PhysicalHealthLevelController()),
        ChangeNotifierProvider(create: (_) => MentalHealthLevelController()),
        ChangeNotifierProvider(create: (_) => EmotionalHealthLevelController()),
        ChangeNotifierProvider(create: (_) => EatingHabitLevelController()),
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => GenderController()),
        ChangeNotifierProvider(create: (_) => NavbarController()),
        ChangeNotifierProvider(create: (_) => AudioPlayerController()),
        ChangeNotifierProvider(create: (_) => CallController()),
      ],
      child: child,
    );
  }
}
