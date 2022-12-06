import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class ReviewController extends BaseController {
  final IReviewService _reviewService;

  ReviewController({required IReviewService reviewService})
      : _reviewService = reviewService;

  ReviewInfo? _reviewInfo;
  ReviewInfo? get reviewInfo => _reviewInfo;
  List<Review> _reviews = [];
  List<Review> get reviews => _reviews;

  Future<void> getAllReviewForTherapist(int id) async {
    reset();
    try {
      setIsLoading(true);
      final result = await _reviewService.getTherapistReviewInfo(id);
      _reviewInfo = result;
      _reviews = result.reviews;
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> create({
    required int therapistId,
    required double rating,
    required String comment,
    required DateTime createdAt,
  }) async {
    try {
      setIsLoading(true);
      await _reviewService.create(
        therapistId: therapistId,
        rating: rating,
        comment: comment,
        createdAt: createdAt,
      );
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
