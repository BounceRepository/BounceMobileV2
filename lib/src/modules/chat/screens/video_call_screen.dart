import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/end_session_prompt_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/call_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/widgets/call_controls_view.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({
    super.key,
    required this.sessionId,
    required this.therapist,
  });

  final int sessionId;
  final Therapist therapist;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
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
        await controller.setupVideoSDKEngine();
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
    return WillPopScope(
      onWillPop: () {
        endSessionPrompt(
          context: context,
          sessionId: widget.sessionId,
          therapist: widget.therapist,
          isCallSession: true,
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: isLoading
            ? const CustomAppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              )
            : null,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Consumer<CallController>(
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
                      'Setting up video',
                      style: AppText.bold600(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }

              final error = controller.failure;
              if (error != null) {
                return ErrorScreen(
                  textColor: Colors.white,
                  error: error,
                  retry: init,
                );
              }

              if (controller.engineStarted) {
                return Stack(
                  children: [
                    const Positioned.fill(child: _RemoteVideoView()),
                    Positioned(
                      top: AppPadding.vertical,
                      right: AppPadding.horizontal,
                      child: const _LocalVideoView(),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        bottomNavigationBar: isLoading
            ? const SizedBox.shrink()
            : CallControlsView(
                sessionId: widget.sessionId,
                therapist: widget.therapist,
                backgroundColor: Colors.white,
                iconColor: Colors.white,
              ),
      ),
    );
  }
}

class _RemoteVideoView extends StatelessWidget {
  const _RemoteVideoView();

  @override
  Widget build(BuildContext context) {
    final sessionJoiningDetails =
        context.watch<SessionController>().sessionJoiningDetails;

    if (sessionJoiningDetails == null) {
      return const SizedBox.shrink();
    }

    final controller = context.watch<CallController>();
    final remoteUid = controller.remoteUid;
    final isJoined = controller.isJoined;

    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.agoraEngine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: sessionJoiningDetails.channel),
        ),
      );
    } else {
      String msg = '';
      if (isJoined) msg = 'Waiting for a remote user to join';
      return Center(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: AppText.bold600(context).copyWith(
            color: Colors.white,
          ),
        ),
      );
    }
  }
}

class _LocalVideoView extends StatelessWidget {
  const _LocalVideoView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CallController>();

    return Container(
      height: 120.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary, width: 2.h),
      ),
      child: AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: controller.agoraEngine,
          canvas: VideoCanvas(uid: controller.uid),
        ),
      ),
    );
  }
}
