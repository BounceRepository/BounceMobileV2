import 'dart:ui';

import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JoinSessionScreen extends StatelessWidget {
  const JoinSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: CachedNetworkImage(
        imageUrl: AppImages.joinSession,
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        // progressIndicatorBuilder: (context, url, downloadProgress) =>
        //     CircularProgressIndicator(value: downloadProgress.progress),
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'Loading....',
            style: AppText.bold400(context).copyWith(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: 250.h,
            padding: EdgeInsets.only(
              top: 32.h,
              left: 44.w,
              right: 44.w,
              bottom: 50.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
              ),
            ),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Welcome to your consultation with ',
                    style: AppText.bold500(context).copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Dr Bellamy',
                        style: AppText.bold700(context).copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: ', let’s talk!',
                        style: AppText.bold500(context).copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                const _ActionButtonsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButtonsSection extends StatelessWidget {
  const _ActionButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40.w,
      children: [
        button(
          icon: AppIcons.message,
          onTap: () {},
        ),
        button(
          icon: AppIcons.call,
          onTap: () {},
        ),
        button(
          icon: AppIcons.video,
          onTap: () {},
        ),
      ],
    );
  }

  Widget button({
    required String icon,
    required Function() onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 22.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        gradient: RadialGradient(
          colors: [
            const Color(0xffFAFAFA),
            const Color(0xffF6F6F6).withOpacity(.4),
          ],
        ),
      ),
      child: SvgPicture.asset(
        icon,
        height: 24.h,
        width: 24.h,
        fit: BoxFit.cover,
        color: AppColors.primary,
      ),
    );
  }
}
