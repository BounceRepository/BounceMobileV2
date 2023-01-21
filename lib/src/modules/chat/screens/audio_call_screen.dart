import 'dart:ui';

import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/call_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/widgets/call_controls_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({
    super.key,
    required this.sessionId,
    required this.therapist,
  });

  final int sessionId;
  final Therapist therapist;

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    final sessionJoiningDetails = context.read<SessionController>().sessionJoiningDetails;

    if (sessionJoiningDetails != null) {
      final controller = context.read<CallController>();
      try {
        setState(() => isLoading = true);
        await controller.setupVoiceSDKEngine();
        await controller.join(sessionJoiningDetails);
        setState(() => isLoading = false);
      } on Failure catch (e) {
        controller.setFailure(e);
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoading ? const CustomAppBar() : null,
      body: Consumer<CallController>(
        builder: (context, controller, _) {
          if (isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Setting up audio',
                  style: AppText.bold600(context),
                ),
              ],
            );
          }

          final error = controller.failure;
          if (error != null) {
            return ErrorScreen(
              error: error,
              retry: init,
            );
          }

          String statusText;

          if (controller.remoteUid == null) {
            statusText = 'Waiting for a remote user to join...';
          } else {
            statusText = 'Connected';
          }

          return Column(
            children: [
              const Spacer(flex: 2),
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(80.sp),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.1),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 16, color: const Color(0xffF5B283)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 7, color: const Color(0xffF5BB91)),
                          ),
                          child: CustomCacheNetworkImage(
                            image: widget.therapist.profilePicture,
                            size: 168.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                widget.therapist.nameWithTitle,
                style: AppText.bold700(context).copyWith(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                statusText,
                style: AppText.bold300(context).copyWith(
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(flex: 4),
            ],
          );
        },
      ),
      bottomNavigationBar: isLoading
          ? const SizedBox.shrink()
          : CallControlsView(
              sessionId: widget.sessionId,
              therapist: widget.therapist,
              backgroundColor: Colors.black,
              iconColor: AppColors.textGrey,
            ),
    );
  }
}
