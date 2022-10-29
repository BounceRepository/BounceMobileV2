import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRatingInfoView extends StatelessWidget {
  const StarRatingInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      runSpacing: 16.h,
      children: List.generate(5, (index) => const _RatingProgressTile()),
    );
  }
}

class _RatingProgressTile extends StatelessWidget {
  const _RatingProgressTile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '5',
          style: AppText.bold300(context).copyWith(
            fontSize: 12.sp,
          ),
        ),
        SizedBox(width: 4.59.w),
        Icon(
          Icons.star,
          size: 11.sp,
          color: AppColors.primary,
        ),
        SizedBox(width: 20.37.w),
        const Expanded(child: CustomProgressIndicator()),
        SizedBox(width: 20.w),
        Text(
          '8%',
          style: AppText.bold500(context).copyWith(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
