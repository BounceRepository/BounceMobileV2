import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

abstract class FeedController extends BaseController {
  final IFeedService _feedService;
  final IFeedListService _feedListService;

  FeedController(
      {required IFeedService feedService, required IFeedListService feedListService})
      : _feedService = feedService,
        _feedListService = feedListService;

  List<Feed> _feeds = [];
  List<Feed> get feeds => _feeds;

  FeedGroup? selectedFeedGroup;

  Future<void> getFeedList();

  Future<void> create({
    required String message,
    required int feedGroupId,
  }) async {
    try {
      setIsLoading(true);
      await _feedService.create(
        message: message,
        feedGroupId: feedGroupId,
      );
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> likeFeed(int feedId) async {
    try {
      _computeFeedLike(feedId);
      await _feedService.likeFeed(feedId);
    } on Failure {
      _computeFeedLike(feedId);
      rethrow;
    }
  }

  void _computeFeedLike(int feedId) {
    final feed = feeds.firstWhere((element) => element.id == feedId);

    if (feed.isLikedByMe == true) {
      feed.isLikedByMe = false;
      feed.likesCount--;
      notifyListeners();
    } else {
      feed.isLikedByMe = true;
      feed.likesCount++;
      notifyListeners();
    }
  }

  void clear() {
    _feeds.clear();
  }
}

class MyFeedController extends FeedController {
  MyFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllMyFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}

class RelationShipFeedController extends FeedController {
  RelationShipFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllRelationshipFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}

class SelfCareFeedController extends FeedController {
  SelfCareFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllSelfCareFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}

class WorkEthnicsFeedController extends FeedController {
  WorkEthnicsFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllWorkEthnicsFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}

class FamilyFeedController extends FeedController {
  FamilyFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllFamilyFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}

class SexualityFeedController extends FeedController {
  SexualityFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllSexualityFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}

class ParentingFeedController extends FeedController {
  ParentingFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllParentingFeed();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
