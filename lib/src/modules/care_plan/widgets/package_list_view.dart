import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionPackageListView extends StatelessWidget {
  const SubscriptionPackageListView(
    this.subplan, {
    Key? key,
  }) : super(key: key);

  final SubPlan subplan;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.h,
      direction: Axis.vertical,
      children: [
        _Tile(label: '${subplan.freeTrialCount} days free trial.'),
        _Tile(label: '${subplan.meditationCount}+ daily meditations.'),
        _Tile(label: '${subplan.therapistCount}+ therapists.'),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_box_outlined,
          size: 20.sp,
          color: AppColors.lightText,
        ),
        SizedBox(width: 16.w),
        Text(
          label,
          style: AppText.bold300(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
