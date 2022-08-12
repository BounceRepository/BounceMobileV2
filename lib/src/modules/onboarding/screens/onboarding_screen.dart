import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/models/onboarding.dart';
import 'package:bounce_patient_app/src/modules/onboarding/screens/getting_started_screen.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/text_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/custom_text_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 25.w,
                  top: 20.h,
                ),
                child: CustomTextButton(
                  label: 'Skip',
                  padding: EdgeInsets.zero,
                  onTap: () {
                    AppNavigator.to(context, const GettingStartedScreen());
                  },
                ),
              ),
            ),
            Consumer<OnboardingController>(
              builder: (BuildContext context, controller, Widget? child) {
                return Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: 3.0,
                          child: Transform.scale(
                            scale: 1.7,
                            child: Container(
                              height: 100.h,
                              color: AppColors.primary.withOpacity(.2),
                            ),
                          ),
                        ),
                        CarouselSlider.builder(
                          carouselController: controller.carouselController,
                          itemCount: controller.onboardings.length,
                          options: CarouselOptions(
                            height: 700.h,
                            viewportFraction: 1,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 6),
                            enableInfiniteScroll: false,
                            initialPage: 0,
                            scrollPhysics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value, _) {
                              controller.nextPage(value);
                            },
                          ),
                          itemBuilder: (context, index, _) {
                            final onboarding = controller.onboardings[index];
                            return _PageViewItem(onboarding);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0),
              AppColors.primary.withOpacity(.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.05.h, 1.0.h],
          ),
        ),
        padding: EdgeInsets.only(
          top: 100.h,
          left: 30.w,
          right: 30.w,
          bottom: 40.h,
        ),
        child: AppButton(
          label: 'Get Started',
          onTap: () {
            AppNavigator.to(context, const GettingStartedScreen());
          },
        ),
      ),
    );
  }
}

class _PageViewItem extends StatelessWidget {
  const _PageViewItem(this.onboarding, {Key? key}) : super(key: key);

  final Onboarding onboarding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              width: 318.w,
              child: Text(
                onboarding.title,
                textAlign: TextAlign.center,
                style: AppText.bold700(context).copyWith(
                  fontSize: 28.sp,
                  height: TextHelperFunctions.calcTextLineHeight(
                    fontSize: 28.sp,
                    designLineHeightValue: 42.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 318.w,
              child: Text(
                onboarding.description,
                textAlign: TextAlign.center,
                style: AppText.bold400(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: FittedBox(
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              onboarding.image,
              height: 439.h,
              width: 328.w,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ],
    );
  }
}
