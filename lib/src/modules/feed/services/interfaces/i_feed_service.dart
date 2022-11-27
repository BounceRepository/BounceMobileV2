import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';

abstract class IFeedService {
  Future<void> likeFeed(int feedId);
  Future<void> create(Feed feed);
}

abstract class IFeedListService {
  Future<List<Feed>> getAllTrending();
  // Future<List<Feed>> getAllRelationship();
  // Future<List<Feed>> getAllSelfCare();
  // Future<List<Feed>> getAllWorkEthnics();
  // Future<List<Feed>> getAllFamily();
  // Future<List<Feed>> getAllSexuality();
  // Future<List<Feed>> getAllParenting();
}
