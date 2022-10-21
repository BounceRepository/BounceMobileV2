import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppIcons.emptyView,
      width: 256.w,
      height: 212.h,
      fit: BoxFit.cover,
    );
  }
}