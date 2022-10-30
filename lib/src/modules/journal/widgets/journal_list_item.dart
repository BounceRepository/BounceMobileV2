import 'package:bounce_patient_app/src/modules/journal/screens/edit_journal_screen.dart';
import 'package:bounce_patient_app/src/modules/journal/widgets/delete_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JournalListItem extends StatelessWidget {
  const JournalListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, const EditJournalScreen());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xffFCE7D8).withOpacity(.4),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lorem(paragraphs: 1, words: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bold600(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    lorem(paragraphs: 1, words: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bold300(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'October 17, 2022 10:17PM',
                    style: AppText.bold500(context).copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 46.5.w),
            GestureDetector(
              onTap: () => _showActionsBottomsheet(context: context),
              child: Icon(
                Icons.more_vert,
                color: AppColors.lightText,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _showActionsBottomsheet({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    body: const _ActionsBody(),
  );
}

class _ActionsBody extends StatelessWidget {
  const _ActionsBody();

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        button(
          context: context,
          icon: AppIcons.delete,
          iconColor: AppColors.error,
          label: 'Delete',
          onTap: () {
            Navigator.pop(context);
            showDeleteJournalPromptBottomsheet(context: context);
          },
        ),
        SizedBox(height: 29.h),
      ],
    );
  }

  Widget button({
    required BuildContext context,
    required String icon,
    Color? iconColor,
    required String label,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.cover,
            color: iconColor,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppText.bold500(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
