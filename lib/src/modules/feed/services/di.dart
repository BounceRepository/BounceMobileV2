import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/comment_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_comment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_comment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_service_impl.dart';

void feedControllersInit({required bool useFake}) {
  _commentControllers(useFake: useFake);
  _feedControllers(useFake: useFake);
}

void _feedControllers({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => TrendingFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
  } else {
    diContainer.registerFactory(() => TrendingFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
  }
}

void _commentControllers({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => TrendingCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
  } else {
    diContainer.registerFactory(() => TrendingCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
  }
}

void feedServicesInit() {
  // diContainer
  //     .registerLazySingleton<IFeedListService>(() => FeedListService(api: diContainer()));
}
