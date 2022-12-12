import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';

abstract class IFeedService {
  Future<void> likeFeed(int feedId);
  Future<void> create({
    required String message,
    required int feedGroupId,
  });
}

abstract class IFeedListService {
  Future<List<Feed>> getAllMyFeed();
  Future<List<Feed>> getAllRelationshipFeed();
  Future<List<Feed>> getAllSelfCareFeed();
  Future<List<Feed>> getAllWorkEthnicsFeed();
  Future<List<Feed>> getAllFamilyFeed();
  Future<List<Feed>> getAllSexualityFeed();
  Future<List<Feed>> getAllParentingFeed();
}
