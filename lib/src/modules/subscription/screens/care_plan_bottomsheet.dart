import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';
import 'package:bounce_patient_app/src/modules/subscription/widgets/package_list_view.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/amount_text.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_pageview_indicator.dart';
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

class _Body extends StatefulWidget {
  const _Body(this.plan);

  final Plan plan;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      padding: EdgeInsets.zero,
      body: [
        SizedBox(height: 20.h),
        Text(
          widget.plan.label,
          style: AppText.bold700(context).copyWith(
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 76.h),
        SizedBox(
          height: 345.h,
          child: PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) {
              currentPage = value;
              setState(() {});
            },
            children: [
              _PageViewItem(
                plan: widget.plan,
                period: 'quarter',
              ),
              _PageViewItem(
                plan: widget.plan,
                period: 'annual',
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
        CustomPageViewIndicator(
          pageController: pageController,
          length: 2,
          currentPage: currentPage,
          height: 8.h,
          radius: 4.r,
          activeWidth: 32.w,
          inActiveWidth: 16.w,
        ),
        SizedBox(height: 60.h),
      ],
    );
  }
}

class _PageViewItem extends StatelessWidget {
  const _PageViewItem({
    Key? key,
    required this.plan,
    required this.period,
  }) : super(key: key);

  final Plan plan;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: AppPadding.horizontal,
      ),
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
                '/$period',
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
    );
  }
}
