import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.tabs,
    this.isScrollable = false,
    this.padding,
    this.controller,
    this.onTap,
  }) : super(key: key);

  final TabController? controller;
  final List<Widget> tabs;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: TabBar(
        isScrollable: isScrollable,
        controller: controller,
        onTap: onTap,
        physics: const BouncingScrollPhysics(),
        labelColor: AppColors.grey,
        unselectedLabelColor: AppColors.textBrown,
        labelStyle: AppText.bold600(context).copyWith(
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: AppText.bold600(context).copyWith(
          fontSize: 12.sp,
        ),
        indicatorColor: Colors.transparent,
        indicatorPadding: EdgeInsets.zero,
        padding: padding ?? EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
        labelPadding: EdgeInsets.only(right: 12.w),
        tabs: tabs,
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    Key? key,
    required this.text,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final String text;
  final int index;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        color: controller.index == index ? AppColors.chatRoom : const Color(0xffF4F2F1),
      ),
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}
