import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeFeedServiceImpl implements IFeedService {
  @override
  Future<void> create(Feed feed) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> likeFeed(int feedId) async {
    await fakeNetworkDelay();
    throw InternalFailure();
  }
}
