import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkText extends StatelessWidget {
  const LinkText({
    Key? key,
    required this.text1,
    required this.text2,
    this.fontSize,
    required this.onClick,
  }) : super(key: key);

  final String text1;
  final String text2;
  final double? fontSize;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: RichText(
        text: TextSpan(
          text: '$text1 ',
          style: AppText.bold300(context).copyWith(
            fontSize: fontSize ?? 12.sp,
          ),
          children: <TextSpan>[
            TextSpan(
              text: text2,
              style: AppText.bold600(context).copyWith(
                fontSize: fontSize ?? 12.sp,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
