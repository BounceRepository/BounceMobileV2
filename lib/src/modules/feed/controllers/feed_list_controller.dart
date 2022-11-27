import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class FeedListController extends BaseController {
  final IFeedListService _feedListService;

  FeedListController({required IFeedListService feedListService})
      : _feedListService = feedListService;

  List<Feed> _feeds = [];
  List<Feed> get feeds => _feeds;

  Future<void> getAllTrending() async {
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
