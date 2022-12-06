import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';

abstract class IReviewService {
  Future<ReviewInfo> getTherapistReviewInfo(int id);
  Future<void> create({
    required int therapistId,
    required int rating,
    required String comment,
    required DateTime createdAt,
  });
}
