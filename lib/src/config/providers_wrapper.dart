import 'package:bounce_patient_app/src/modules/book_session/controllers/book_session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/gender_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/controllers/health_level_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_list_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/mood_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/controllers/navbar_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/audio_player_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/reviews/controllers/review_controller.dart';
import 'package:bounce_patient_app/src/modules/subscription/controllers/subscription_list_controller.dart';
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
        ChangeNotifierProvider(create: (_) => diContainer<AuthController>()),
        ChangeNotifierProvider(create: (_) => diContainer<ImageController>()),
        ChangeNotifierProvider(create: (_) => diContainer<TherapistListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<BookSessionController>()),
        ChangeNotifierProvider(create: (_) => diContainer<SessionListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<MoodController>()),
        ChangeNotifierProvider(create: (_) => diContainer<NotificationController>()),
        ChangeNotifierProvider(create: (_) => diContainer<SongListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<TransactionListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<WalletController>()),
        ChangeNotifierProvider(create: (_) => diContainer<JournalController>()),
        ChangeNotifierProvider(create: (_) => diContainer<SubscriptionListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<ChatListController>()),
        ChangeNotifierProvider(create: (_) => diContainer<FeedController>()),
        ChangeNotifierProvider(create: (_) => diContainer<TrendingFeedController>()),
        ChangeNotifierProvider(create: (_) => diContainer<CommentController>()),
        ChangeNotifierProvider(create: (_) => diContainer<TrendingCommentController>()),
        ChangeNotifierProvider(create: (_) => diContainer<ReviewController>()),
        ChangeNotifierProvider(create: (_) => HealthLevelController()),
        ChangeNotifierProvider(create: (_) => PhysicalHealthLevelController()),
        ChangeNotifierProvider(create: (_) => MentalHealthLevelController()),
        ChangeNotifierProvider(create: (_) => EmotionalHealthLevelController()),
        ChangeNotifierProvider(create: (_) => EatingHabitLevelController()),
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => GenderController()),
        ChangeNotifierProvider(create: (_) => NavbarController()),
        ChangeNotifierProvider(create: (_) => AudioPlayerController()),
      ],
      child: child,
    );
  }
}
