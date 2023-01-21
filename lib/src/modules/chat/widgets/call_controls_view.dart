import 'dart:developer';
import 'dart:ui';

import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/end_session_prompt_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/call_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CallControlsView extends StatelessWidget {
  const CallControlsView({
    super.key,
    required this.sessionId,
    required this.therapist,
    required this.backgroundColor,
    required this.iconColor,
  });

  final int sessionId;
  final Therapist therapist;
  final Color backgroundColor;
  final Color iconColor;

  void onMicPressed(BuildContext context) async {
    try {
      await context.read<CallController>().onMicPressed();
    } on Failure catch (e) {
      log(e.message);
    }
  }

  void onSpeakerPressed(BuildContext context) async {
    try {
      await context.read<CallController>().onSpeakerPressed();
    } on Failure catch (e) {
      log(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CallController>();

    if (controller.failure != null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 40.h, right: 20.w, left: 20.w),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 40.w, left: 40.w),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => onMicPressed(context),
                icon: Icon(
                  controller.isMuted ? Icons.mic_off_outlined : Icons.mic,
                  color: iconColor,
                  size: 20.sp,
                ),
              ),
              const Spacer(),
              _EndButton(
                onTap: () => endSessionPrompt(
                  context: context,
                  sessionId: sessionId,
                  therapist: therapist,
                  isCallSession: true,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => onSpeakerPressed(context),
                icon: Icon(
                  controller.inSpeakerMode
                      ? Icons.volume_up_outlined
                      : Icons.volume_off_outlined,
                  color: iconColor,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EndButton extends StatelessWidget {
  const _EndButton({required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68.h,
        width: 68.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.error,
        ),
        child: Icon(
          Icons.call_end_outlined,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }
}
