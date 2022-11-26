import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen(this.precription, {super.key});

  final Precription precription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(label: 'Prescription'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppIcons.prescription,
              width: 256.w,
              height: 212.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 48.h),
          _ColumnText(title: 'Drug', content: precription.drugName),
          _ColumnText(title: 'Dosage', content: precription.dosage),
          _ColumnText(title: 'Description', content: precription.desc),
        ],
      ),
    );
  }
}

class _ColumnText extends StatelessWidget {
  const _ColumnText({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            left: AppPadding.horizontal,
            right: AppPadding.horizontal,
            bottom: 16.h,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: AppText.bold500(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                content,
                style: AppText.bold300(context).copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        const CustomDivider(),
      ],
    );
  }
}
