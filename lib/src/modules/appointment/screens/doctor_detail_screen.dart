import 'package:bounce_patient_app/src/modules/appointment/screens/screens.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: CustomChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 124.h,
                  bottom: 24.h,
                  right: AppPadding.horizontal,
                  left: AppPadding.horizontal,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffFEF3E7),
                      Color(0xffFCFAFA),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DefaultAppImage(size: 100.h),
                    SizedBox(height: 24.h),
                    Text(
                      'Dr. Bellamy Nicholas',
                      textAlign: TextAlign.center,
                      style: AppText.bold700(context).copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Psycologist',
                      textAlign: TextAlign.center,
                      style: AppText.bold400(context).copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 36.h),
                    Row(
                      children: [
                        infoCard(context, title: '1000+', subTitle: 'Patients'),
                        SizedBox(width: 16.w),
                        infoCard(context, title: '10 Years', subTitle: 'Experience'),
                        SizedBox(width: 16.w),
                        infoCard(context, title: '4.5', subTitle: 'Ratings'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: AppPadding.horizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    columnText(
                      context,
                      title: 'About',
                      description: lorem(paragraphs: 1, words: 25),
                    ),
                    SizedBox(height: 24.h),
                    columnText(
                      context,
                      title: 'Working Hours',
                      description: 'Monday - Saturday (08:30 AM - 09:00 PM)',
                    ),
                    SizedBox(height: 24.h),
                    const _CommunicationSection(),
                    SizedBox(height: 46.h),
                    AppButton(
                      label: 'Book Session',
                      onTap: () {
                        AppNavigator.to(context, const BookSessionScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 28.h, bottom: 36.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppText.bold700(context).copyWith(
                fontSize: 18.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subTitle,
              style: AppText.bold400(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget columnText(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppText.bold600(context).copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          style: AppText.bold400(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class _CommunicationSection extends StatelessWidget {
  const _CommunicationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Communication',
          textAlign: TextAlign.center,
          style: AppText.bold600(context).copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.h),
        tile(
          context,
          icon: AppIcons.message,
          title: 'Messaging',
          subTitle: 'Chat and share photos.',
          onTap: () {},
        ),
        SizedBox(height: 20.h),
        tile(
          context,
          icon: AppIcons.call,
          title: 'Audio Call',
          subTitle: 'Place a call directly to your doctor.',
          onTap: () {},
        ),
        SizedBox(height: 20.h),
        tile(
          context,
          icon: AppIcons.video,
          title: 'Video Call',
          subTitle: 'Chat and share photos.',
          onTap: () {},
        ),
      ],
    );
  }

  Widget tile(
    BuildContext context, {
    required String icon,
    required String title,
    required String subTitle,
    required Function() onTap,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: const Color(0xffFCE7D8).withOpacity(.52),
          ),
          child: SvgPicture.asset(
            icon,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.fill,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppText.bold600(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subTitle,
                style: AppText.bold400(context).copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
