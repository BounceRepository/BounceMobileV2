import 'package:bounce_patient_app/src/modules/dashboard/controllers/navbar_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/models/navbar_item.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavbarController>(
      builder: (context, controller, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: controller.selectedItem.screen,
          bottomNavigationBar: CustomBottomNavBar(items: controller.items),
        );
      },
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key, required this.items}) : super(key: key);

  final List<NavbarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.11),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return _NavBarItem(
            index: index,
            item: item,
          );
        }),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  final int index;
  final NavbarItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NavbarController>().onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: Add semi-cirle dashboard indicator
          SizedBox(height: 20.h),
          SvgPicture.asset(
            item.icon,
            height: 28.h,
            width: 28.h,
            color: item.selected ? AppColors.primary : const Color(0xffD9D8D8),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }
}
