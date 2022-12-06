import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRatingInfoView extends StatelessWidget {
  const StarRatingInfoView({super.key, required this.reviewInfo});

  final ReviewInfo reviewInfo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      runSpacing: 16.h,
      children: [
        _RatingProgressTile(
          value: reviewInfo.fiveStarPercentage,
          percent: reviewInfo.fiveStarPercentage,
          starCount: 5,
        ),
        _RatingProgressTile(
          value: reviewInfo.fourStarPercentage,
          percent: reviewInfo.fourStarPercentage,
          starCount: 4,
        ),
        _RatingProgressTile(
          value: reviewInfo.threeStarPercentage,
          percent: reviewInfo.threeStarPercentage,
          starCount: 3,
        ),
        _RatingProgressTile(
          value: reviewInfo.twoStarPercentage,
          percent: reviewInfo.twoStarPercentage,
          starCount: 2,
        ),
        _RatingProgressTile(
          value: reviewInfo.oneStarPercentage,
          percent: reviewInfo.oneStarPercentage,
          starCount: 1,
        ),
      ],
    );
  }
}

class _RatingProgressTile extends StatelessWidget {
  const _RatingProgressTile({
    required this.value,
    required this.percent,
    required this.starCount,
  });

  final double value;
  final double percent;
  final int starCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 255.w,
      child: Row(
        children: [
          Text(
            starCount.toString(),
            style: AppText.bold300(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.star,
            size: 11.sp,
            color: AppColors.primary,
          ),
          const Spacer(),
          SizedBox(
            width: 172.w,
            child: CustomProgressIndicator(value: value),
          ),
          const Spacer(),
          Text(
            '$percent%',
            style: AppText.bold500(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
