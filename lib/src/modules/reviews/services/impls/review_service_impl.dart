import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class ReviewServiceImpl implements IReviewService {
  final IApi _api;

  ReviewServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> create({
    required int therapistId,
    required double rating,
    required String comment,
    required DateTime createdAt,
  }) async {
    var body = {
      "reviewComment": comment,
      "reviewStarCount": rating.toInt().toString(),
      "time": createdAt.toIso8601String(),
      "therapistUserId": therapistId.toString()
    };

    try {
      await _api.post(ReviewApiURLS.create, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<ReviewInfo> getTherapistReviewInfo(int id) async {
    var url = ReviewApiURLS.getTherapistReviewInfo + '?therapistId=$id';
    try {
      final response = await _api.get(url);
      return ReviewInfo.fromJson(response['data']);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
