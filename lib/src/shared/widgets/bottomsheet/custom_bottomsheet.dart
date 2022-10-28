import 'dart:ui';

import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showCustomBottomSheet(
  BuildContext context, {
  required Widget body,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  final size = MediaQuery.of(context).size.height;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: enableDrag,
    constraints: BoxConstraints(
      maxHeight: size,
    ),
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: body,
    ),
  );
}

class CustomBottomSheetBody extends StatelessWidget {
  const CustomBottomSheetBody({
    Key? key,
    required this.body,
    this.padding,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  final List<Widget> body;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        padding: padding ??
            EdgeInsets.only(
              top: 20.73.h,
              right: AppPadding.horizontal,
              left: AppPadding.horizontal,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: body,
          ),
        ),
      ),
    );
  }
}
