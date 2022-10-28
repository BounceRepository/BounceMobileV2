import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';
import 'package:bounce_patient_app/src/modules/subscription/widgets/package_list_view.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showCarePlanBottomsheet({
  required BuildContext context,
  required Plan plan,
}) {
  return showCustomBottomSheet(
    context,
    body: _Body(plan),
  );
}

class _Body extends StatelessWidget {
  const _Body(this.plan);

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        Text(
          plan.label,
          style: AppText.bold700(context).copyWith(
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 76.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 48.h, bottom: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: AppColors.boxshadow4,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AmountText(
                    amount: plan.amount,
                    symbolFontSize: 20.sp,
                    amountFontSize: 28.sp,
                  ),
                  Text(
                    '/quarter',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36.h),
              Align(
                alignment: Alignment.center,
                child: SubscriptionPackageListView(plan.packages),
              ),
              SizedBox(height: 48.h),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: AppButton(
                    label: 'Choose Plan',
                    labelColor: AppColors.lightVersion,
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 48.h),
      ],
    );
  }
}
