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

  String? selectedFeedGroup;

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
}

class TrendingFeedController extends FeedController {
  TrendingFeedController({
    required super.feedService,
    required super.feedListService,
  });

  @override
  Future<void> getFeedList() async {
    reset();
    try {
      setIsLoading(true);
      _feeds = await _feedListService.getAllTrending();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
