import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          DefaultAppImage(size: 48.h),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Kingsley',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                CustomStarRating(rating: 4, size: 14.sp),
                SizedBox(height: 12.86.h),
                Text(
                  lorem(paragraphs: 1, words: 25),
                  style: AppText.bold300(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  '12h ago',
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
