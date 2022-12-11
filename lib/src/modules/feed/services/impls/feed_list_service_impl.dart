import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class FeedListServiceImpl implements IFeedListService {
  final IApi _api;

  FeedListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Feed>> getAllTrending() async {
    try {
      final response = await _api.get(FeedApiURLS.getAllFeed);
      final List collection = response['data'];
      return collection.map((json) => Feed.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
