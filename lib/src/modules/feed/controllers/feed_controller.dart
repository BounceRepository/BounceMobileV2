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

  Future<void> getFeedList();

  Future<void> create(Feed feed) async {
    try {
      await _feedService.create(feed);
    } on Failure {
      rethrow;
    }
  }

  Future<void> likeFeed(int feedId) async {
    try {
      _increaseFeedLikeCount(feedId);
      await _feedService.likeFeed(feedId);
    } on Failure {
      _decreaseFeedLikeCount(feedId);
      rethrow;
    }
  }

  void _increaseFeedLikeCount(int feedId) {
    final feed = feeds.firstWhere((element) => element.id == feedId);
    feed.likesCount++;
    notifyListeners();
  }

  void _decreaseFeedLikeCount(int feedId) {
    final feed = feeds.firstWhere((element) => element.id == feedId);
    feed.likesCount--;
    notifyListeners();
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
