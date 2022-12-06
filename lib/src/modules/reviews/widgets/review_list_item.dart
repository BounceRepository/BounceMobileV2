import 'package:bounce_patient_app/src/modules/reviews/models/review.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem(this.review, {super.key});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCacheNetworkImage(
            image: review.reviewerProfilePic,
            size: 48.h,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.reviewerName.toTitleCase,
                  style: AppText.bold700(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                CustomStarRating(rating: review.rating.toDouble(), size: 14.sp),
                SizedBox(height: 12.86.h),
                Text(
                  review.comment,
                  style: AppText.bold300(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  review.formattedTime,
                  style: AppText.bold400(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
