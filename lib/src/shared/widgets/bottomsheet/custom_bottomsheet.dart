import 'dart:ui';

import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
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
            borderRadius: borderRadius ??
                BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: body,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: AppText.bold700(context).copyWith(
          fontSize: 20.sp,
        ),
      ),
    );
  }
}

class Dragger extends StatelessWidget {
  const Dragger({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.grey5,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
