import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/comment_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_comment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_comment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/fakes/fake_feed_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/comment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/comment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/feed_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/impls/feed_service_impl.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';

void feedControllersInit({required bool useFake}) {
  _commentControllers(useFake: useFake);
  _feedControllers(useFake: useFake);
}

void _feedControllers({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => MyFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => RelationShipFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => SelfCareFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => WorkEthnicsFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => FamilyFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => SexualityFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
    diContainer.registerFactory(() => ParentingFeedController(
          feedService: FakeFeedServiceImpl(),
          feedListService: FakeFeedListServiceImpl(),
        ));
  } else {
    diContainer.registerFactory(() => MyFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => RelationShipFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => SelfCareFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => WorkEthnicsFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => FamilyFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => SexualityFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
    diContainer.registerFactory(() => ParentingFeedController(
          feedService: diContainer(),
          feedListService: diContainer(),
        ));
  }
}

void _commentControllers({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => MyCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => RelationShipCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => SelfCareCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => WorkEthnicsCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => FamilyCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => SexualityCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
    diContainer.registerFactory(() => ParentingCommentController(
          commentService: FakeCommentServiceImpl(),
          commentListService: FakeCommentListServiceImpl(),
        ));
  } else {
    diContainer.registerFactory(() => MyCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => RelationShipCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => SelfCareCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => WorkEthnicsCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => FamilyCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => SexualityCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
    diContainer.registerFactory(() => ParentingCommentController(
          commentService: diContainer(),
          commentListService: diContainer(),
        ));
  }
}

void feedServicesInit() {
  diContainer
      .registerLazySingleton<IFeedService>(() => FeedServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<IFeedListService>(
      () => FeedListServiceImpl(api: diContainer()));

  diContainer.registerLazySingleton<ICommentService>(
      () => CommentServiceImpl(api: diContainer()));
  diContainer.registerLazySingleton<ICommentListService>(
      () => CommentListServiceImpl(api: diContainer()));
}
