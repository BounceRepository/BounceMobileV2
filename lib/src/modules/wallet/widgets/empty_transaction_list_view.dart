import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EmptyTransactionListView extends StatelessWidget {
  const EmptyTransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.transaction,
          width: 256.w,
          height: 212.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 12.h),
        Text(
          'Nothing to see yet',
          style: AppText.titleStyle(context),
        ),
      ],
    );
  }
}
