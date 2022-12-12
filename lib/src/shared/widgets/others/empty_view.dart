import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({Key? key, this.icon, this.text, this.height}) : super(key: key);

  final String? icon;
  final String? text;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon ?? AppIcons.emptyView,
            width: 256.w,
            height: height ?? 212.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          text ?? 'Nothing to see yet',
          style: AppText.titleStyle(context),
        ),
      ],
    );
  }
}
