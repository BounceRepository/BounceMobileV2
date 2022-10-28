import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/sliver_appbar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWithTabs extends StatelessWidget {
  const AppBarWithTabs({
    super.key,
    this.title,
    required this.tabs,
  });

  final String? title;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        maxHeight: title != null ? 119.h : 60.h,
        minHeight: title != null ? 119.h : 60.h,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != null
                  ? Padding(
                      padding: EdgeInsets.only(top: 20.h, left: AppPadding.horizontal),
                      child: Column(
                        children: [
                          Text(
                            title!,
                            style: AppText.bold700(context).copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: 20.h),
              CustomTabBar(
                isScrollable: true,
                tabs: List.generate(tabs.length, (index) {
                  final tab = tabs[index];
                  return Tab(text: tab);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return Container(
      height: 40.h,
      width: double.infinity,
      margin: EdgeInsets.only(left: AppPadding.horizontal),
      padding: EdgeInsets.only(left: 5.w, top: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r)),
      ),
      child: TabBar(
        isScrollable: isScrollable,
        controller: controller,
        onTap: onTap,
        physics: const BouncingScrollPhysics(),
        labelColor: AppColors.grey,
        unselectedLabelColor: AppColors.grey,
        labelStyle: AppText.bold600(context).copyWith(
          fontSize: 12.sp,
        ),
        unselectedLabelStyle: AppText.bold600(context).copyWith(
          fontSize: 12.sp,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        indicatorPadding: EdgeInsets.zero,
        indicatorWeight: 4.h,
        padding: EdgeInsets.zero,
        tabs: tabs,
      ),
    );
  }
}
