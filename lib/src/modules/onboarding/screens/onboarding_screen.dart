import 'package:bounce_patient_app/src/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bounce_patient_app/src/modules/onboarding/screens/getting_started_screen.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_pageview_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingController>().init();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<OnboardingController>(
      builder: (context, controller, _) {
        final pageController = controller.pageController;

        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: controller.onboardingList.length,
                  itemBuilder: (context, index) {
                    final onboarding = controller.onboardingList[index];
                    return Image.asset(
                      onboarding.image,
                      fit: BoxFit.cover,
                      height: size.height,
                      width: size.width,
                      alignment: Alignment.topCenter,
                    );
                  },
                  onPageChanged: (value) {
                    controller.nextPage(value);
                  },
                ),
              ),
              const Positioned(
                bottom: 0,
                child: _ContentView(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView();

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingController>(builder: (context, controller, _) {
      final currentOnboarding = controller.currentOnboarding;

      return Container(
        height: 320.h,
        width: 375.w,
        padding: EdgeInsets.symmetric(
          vertical: 36.h,
          horizontal: AppPadding.horizontal,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
            topRight: Radius.circular(28.r),
          ),
        ),
        child: Column(
          children: [
            const _Indicator(),
            const Spacer(),
            Text(
              currentOnboarding.title,
              textAlign: TextAlign.center,
              style: AppText.bold700(context).copyWith(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              currentOnboarding.description,
              textAlign: TextAlign.center,
              style: AppText.bold300(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
            const Spacer(),
            AppButton(
              label: 'Get Started',
              onTap: () {
                AppNavigator.to(context, const GettingStartedScreen());
              },
            ),
          ],
        ),
      );
    });
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardingController>();
    final pageController = controller.pageController;

    return CustomPageViewIndicator(
      currentPage: controller.pageNo,
      length: controller.onboardingList.length,
      pageController: pageController,
    );
  }
}
