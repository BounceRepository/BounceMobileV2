import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';

class BottomNavBarContainer extends StatelessWidget {
  const BottomNavBarContainer({super.key, required this.child, this.bottomPadding});

  final Widget child;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: AppPadding.horizontal,
          right: AppPadding.horizontal,
          //bottom: bottomPadding ?? MediaQuery.of(context).padding.bottom,
        ),
        child: child,
      ),
    );
  }
}
