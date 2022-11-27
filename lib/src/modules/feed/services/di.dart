import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/comment_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/comment_list_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_list_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_comment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_comment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_service_impl.dart';

void feedControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => FeedListController(
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => FeedController(
          feedService: FakeFeedServiceImpl(),
        ));
    diContainer.registerFactory(() => CommentListController(
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => CommentController(
          commentService: FakeCommentServiceImpl(),
        ));
  } else {
    diContainer.registerFactory(() => FeedListController(
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => FeedController(
          feedService: diContainer(),
        ));
    diContainer.registerFactory(() => CommentListController(
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => CommentController(
          commentService: diContainer(),
        ));
  }
}

void feedServicesInit() {
  // diContainer
  //     .registerLazySingleton<IFeedListService>(() => FeedListService(api: diContainer()));
}
