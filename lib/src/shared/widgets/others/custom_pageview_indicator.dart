import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPageViewIndicator extends StatelessWidget {
  const CustomPageViewIndicator({
    Key? key,
    required this.pageController,
    required this.length,
    required this.currentPage,
    this.activeWidth,
    this.inActiveWidth,
    this.height,
    this.radius,
  }) : super(key: key);

  final PageController pageController;
  final int currentPage;
  final int length;
  final double? height;
  final double? activeWidth;
  final double? inActiveWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => GestureDetector(
          onTap: () => pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceIn,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            height: height ?? 4.h,
            width: (index == currentPage) ? activeWidth ?? 44.w : inActiveWidth ?? 20.w,
            decoration: BoxDecoration(
              color: (index == currentPage) ? AppColors.primary : AppColors.grey5,
              borderRadius: BorderRadius.circular(radius ?? 20.r),
            ),
          ),
        ),
      ),
    );
  }
}
