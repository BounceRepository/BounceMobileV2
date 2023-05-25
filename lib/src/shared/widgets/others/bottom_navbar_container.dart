import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarContainer extends StatelessWidget {
  const BottomNavBarContainer({super.key, required this.child, this.bottomPadding});

  final Widget child;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: AppPadding.horizontal,
          right: AppPadding.horizontal,
          bottom: bottomPadding ?? 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
