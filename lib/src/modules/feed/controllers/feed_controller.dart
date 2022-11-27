import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class FeedController extends BaseController {
  final IFeedService _feedService;

  FeedController({required IFeedService feedService}) : _feedService = feedService;

  Future<void> likeFeed(int feedId) async {
    try {
      await _feedService.likeFeed(feedId);
    } on Failure {
      rethrow;
    }
  }

  Future<void> create(Feed feed) async {
    try {
      await _feedService.create(feed);
    } on Failure {
      rethrow;
    }
  }
}
