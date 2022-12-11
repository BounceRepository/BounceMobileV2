import 'package:bounce_patient_app/src/modules/feed/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class FeedServiceImpl implements IFeedService {
  final IApi _api;

  FeedServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> create({
    required String message,
    required int feedGroupId,
  }) async {
    var body = {
      "feed": message,
      "feedGroupId": feedGroupId,
      "time": DateTime.now().toIso8601String()
    };

    try {
      await _api.post(FeedApiURLS.createFeed, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> likeFeed(int feedId) async {
    var body = {"feedId": feedId};

    try {
      await _api.patch(FeedApiURLS.likeFeed, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
