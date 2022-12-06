import 'dart:math';

import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';
import 'package:bounce_patient_app/src/modules/reviews/services/interfaces/i_review_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeReviewServiceImpl implements IReviewService {
  @override
  Future<void> create({
    required int therapistId,
    required double rating,
    required String comment,
    required DateTime createdAt,
  }) async {
    await fakeNetworkDelay();
  }

  @override
  Future<ReviewInfo> getTherapistReviewInfo(int id) async {
    await fakeNetworkDelay();
    return ReviewInfo(
      totalReviewCount: Random().nextInt(100),
      avgReviewRating: Random().nextDouble(),
      oneStarPercentage: Random().nextDouble(),
      twoStarPercentage: Random().nextDouble(),
      threeStarPercentage: Random().nextDouble(),
      fourStarPercentage: Random().nextDouble(),
      fiveStarPercentage: Random().nextDouble(),
      reviews: List.generate(
          Random().nextInt(8),
          (index) => Review(
                id: id,
                reviewerName: lorem(paragraphs: 1, words: 2),
                reviewerProfilePic: AppImages.joinSession,
                comment: lorem(paragraphs: 1, words: Random().nextInt(100)),
                rating: Random().nextInt(6),
                createdAt: DateTime.now(),
              )),
    );
  }
}
