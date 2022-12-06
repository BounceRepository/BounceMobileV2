import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarContainer extends StatelessWidget {
  const BottomNavBarContainer({super.key, required this.child, this.bottomPadding});

  final Widget child;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: AppPadding.horizontal,
        right: AppPadding.horizontal,
        bottom: bottomPadding ?? 30.h,
      ),
      child: child,
    );
  }
}
