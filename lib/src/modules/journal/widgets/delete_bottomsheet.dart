import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showDeleteJournalPromptBottomsheet({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    body: const _Body(),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        Text(
          'Are you sure you wish to delete this?',
          textAlign: TextAlign.center,
          style: AppText.bold500(context).copyWith(
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textButton(
              context: context,
              label: 'Cancel',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 100.h),
            textButton(
              context: context,
              label: 'Delete',
              labelColor: AppColors.error,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget textButton({
    required BuildContext context,
    required String label,
    Color? labelColor,
    required Function() onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: AppText.bold500(context).copyWith(
          fontSize: 14.sp,
          color: labelColor,
        ),
      ),
    );
  }
}
