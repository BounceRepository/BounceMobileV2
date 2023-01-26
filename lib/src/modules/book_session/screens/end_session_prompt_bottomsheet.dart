import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/call_controller.dart';
import 'package:bounce_patient_app/src/modules/reviews/screens/add_review_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> endSessionPrompt({
  required BuildContext context,
  required int sessionId,
  required Therapist therapist,
  required bool isCallSession,
}) async {
  return showCustomBottomSheet(
    context,
    isDismissible: false,
    enableDrag: false,
    body: _EndSessionPromptView(
      sessionId: sessionId,
      therapist: therapist,
      isVideoSession: isCallSession,
    ),
  );
}

class _EndSessionPromptView extends StatefulWidget {
  const _EndSessionPromptView({
    required this.sessionId,
    required this.therapist,
    required this.isVideoSession,
  });

  final int sessionId;
  final Therapist therapist;
  final bool isVideoSession;

  @override
  State<_EndSessionPromptView> createState() => _EndSessionPromptViewState();
}

class _EndSessionPromptViewState extends State<_EndSessionPromptView> {
  bool isLoading = false;

  void endSession() async {
    try {
      setState(() => isLoading = true);
      await Future.wait([
        context.read<SessionController>().end(sessionId: widget.sessionId),
        context.read<ChatController>().closeConnection(),
        if (widget.isVideoSession) context.read<CallController>().leave(),
      ]);
      setState(() => isLoading = false);
      showAddReviewBottomsheet(context: context, therapist: widget.therapist);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.therapist.nameWithTitle;

    return CustomBottomSheetBody(
      body: [
        isLoading
            ? Align(
                alignment: Alignment.centerRight,
                child: CloseButton(
                  color: Colors.transparent,
                  onPressed: () {},
                ),
              )
            : const Align(
                alignment: Alignment.centerRight,
                child: CloseButton(),
              ),
        Icon(
          Icons.warning,
          size: 50.sp,
          color: AppColors.primary,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: 350.w,
          child: Text(
            'Are you sure you want to end the consultation session with $name?',
            textAlign: TextAlign.center,
            style: AppText.bold500(context),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Yes',
                isLoading: isLoading,
                onTap: endSession,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: AppButton(
                label: 'No',
                backgroundColor: Colors.grey,
                onTap: isLoading
                    ? () {}
                    : () {
                        Navigator.pop(context);
                      },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
