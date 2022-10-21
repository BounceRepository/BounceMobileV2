import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key, this.size}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.loadingIndicator,
        height: size ?? 100.h,
        width: size ?? 100.h,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
      ),
    );
  }
}
