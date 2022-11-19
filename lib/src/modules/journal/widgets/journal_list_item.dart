import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/modules/journal/screens/edit_journal_screen.dart';
import 'package:bounce_patient_app/src/modules/journal/widgets/delete_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JournalListItem extends StatelessWidget {
  const JournalListItem(this.journal, {super.key});

  final Journal journal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, EditJournalScreen(journal: journal));
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
                    journal.title.toTitleCase,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bold600(context).copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    journal.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bold300(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    journal.date,
                    style: AppText.bold500(context).copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 46.5.w),
            GestureDetector(
              onTap: () => _showActionsBottomsheet(context: context, journal: journal),
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
  required Journal journal,
}) {
  return showCustomBottomSheet(
    context,
    body: _ActionsBody(journal),
  );
}

class _ActionsBody extends StatelessWidget {
  const _ActionsBody(this.journal);

  final Journal journal;

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
            showDeleteJournalPromptBottomsheet(context: context, journal: journal);
          },
        ),
        //SizedBox(height: 29.h),
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
    return InkWell(
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
