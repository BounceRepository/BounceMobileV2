import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SymptomsScreen extends StatelessWidget {
  const SymptomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 54.h),
          child: Column(
            children: [
              SvgPicture.asset(
                AuthIcons.symptoms,
                width: 186.w,
                height: 150.h,
              ),
              SizedBox(height: 29.h),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 22.h,
                  horizontal: 10.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What Symptoms are you experiencing?',
                      style: AppText.bold500(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      'You can choose as many as you like, we will  show recommended therapist and articles according to this',
                      style: AppText.bold400(context).copyWith(
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 15.21.h,
                children: List.generate(10, (index) => const _SymptomButton()),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 100.w,
                child: AppButton(
                  label: 'See More',
                  labelColor: AppColors.primary,
                  backgroundColor: AppColors.grey,
                  onTap: () {},
                ),
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: 'Done',
                onTap: () {},
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SymptomButton extends StatelessWidget {
  const _SymptomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77.17.w,
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,
        vertical: 10.42.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: 50.h,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'data',
            style: AppText.bold500(context).copyWith(
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}
