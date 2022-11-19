import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showDeleteJournalPromptBottomsheet({
  required BuildContext context,
  required Journal journal,
}) {
  return showCustomBottomSheet(
    context,
    body: _Body(journal),
  );
}

class _Body extends StatefulWidget {
  const _Body(this.journal);

  final Journal journal;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool isLoading = false;

  void delete() async {
    final controller = context.read<JournalController>();

    try {
      setState(() => isLoading = true);
      await controller.delete(widget.journal.id);
      Navigator.pop(context);
      Messenger.success(message: 'Deleted successfully');
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      Navigator.pop(context);
      Messenger.error(message: e.message);
    }
  }

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
        isLoading
            ? const CircularProgressIndicator()
            : Row(
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
                    onTap: delete,
                  ),
                ],
              ),
        //SizedBox(height: 20.h),
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
