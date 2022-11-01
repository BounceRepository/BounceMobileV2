import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';
import 'package:bounce_patient_app/src/modules/subscription/screens/care_plan_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/subscription/widgets/package_list_view.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarePlansScreen extends StatelessWidget {
  const CarePlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      Plan(
        label: 'Bronze',
        color: AppColors.bronze,
        amount: 5000,
        packages: [
          '7 days free trial.',
          '100+ daily meditations.',
          '100+ therapists.',
        ],
      ),
      Plan(
        label: 'Silver',
        color: AppColors.sliver,
        amount: 15000,
        packages: [
          '7 days free trial.',
          '100+ daily meditations.',
          '100+ therapists.',
        ],
      ),
      Plan(
        label: 'Gold',
        color: AppColors.gold,
        amount: 25000,
        packages: [
          '7 days free trial.',
          '100+ daily meditations.',
          '100+ therapists.',
        ],
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(label: 'My Care Plans'),
      body: CustomChildScrollView(
        child: Wrap(
          runSpacing: 28.h,
          children: List.generate(plans.length, (index) {
            final plan = plans[index];
            return PlanCard(plan);
          }),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard(this.plan, {super.key});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.lightVersion,
            boxShadow: AppColors.boxshadow4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 48.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.label,
                      style: AppText.bold600(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SubscriptionPackageListView(plan.packages),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: AppButton(
                    label: 'View Pricing',
                    labelColor: AppColors.lightVersion,
                    backgroundColor: plan.color,
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {
                      showCarePlanBottomsheet(context: context, plan: plan);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r)),
          child: SvgPicture.asset(
            AppIcons.triangle,
            width: 52.w,
            height: 48.h,
            fit: BoxFit.cover,
            color: plan.color,
          ),
        ),
      ],
    );
  }
}
