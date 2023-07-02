import 'dart:ui';

import 'package:bounce_patient_app/src/modules/book_session/controllers/controllers.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/audio_call_screen.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/chat_window_screen.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/video_call_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class JoinSessionScreen extends StatefulWidget {
  const JoinSessionScreen({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  State<JoinSessionScreen> createState() => _JoinSessionScreenState();
}

class _JoinSessionScreenState extends State<JoinSessionScreen> {
  Therapist? _therapist;
  bool isReadyToJoin = false;
  bool isStarting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTherapist();
    });
  }

  void getTherapist() async {
    final controller = context.read<BookSessionController>();

    try {
      _therapist = await controller.getOneTherapist(widget.session.therapistId);
    } on Failure catch (e) {
      controller.setFailure(e);
    }
  }

  void startSession() async {
    if (_therapist != null) {
      try {
        setState(() => isStarting = true);
        await context.read<SessionController>().start(sessionId: widget.session.id, therapisId: _therapist!.id);
        isReadyToJoin = true;
        setState(() => isStarting = false);
      } on Failure catch (e) {
        setState(() => isStarting = false);
        Messenger.error(message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = context.watch<BookSessionController>();

    final therapist = _therapist;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        iconTheme: IconThemeData(color: controller.failure != null || controller.isBusy ? Colors.black : Colors.white),
      ),
      body: controller.isBusy
          ? const CustomLoadingIndicator()
          : controller.failure != null
              ? ErrorScreen(error: controller.failure!, retry: getTherapist)
              : therapist == null
                  ? const SizedBox.shrink()
                  : CachedNetworkImage(
                      imageUrl: AppImages.joinSession,
                      height: size.height,
                      width: size.width,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Loading....',
                          style: AppText.bold400(context).copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
      bottomNavigationBar: therapist == null
          ? const SizedBox.shrink()
          : isReadyToJoin
              ? ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      height: 250.h,
                      padding: EdgeInsets.only(
                        top: 32.h,
                        left: 44.w,
                        right: 44.w,
                        bottom: 50.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(.1),
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Welcome to your consultation with ',
                              style: AppText.bold500(context).copyWith(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${therapist.title}, ${therapist.fullName}',
                                  style: AppText.bold700(context).copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: ', let’s talk!',
                                  style: AppText.bold500(context).copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40.h),
                          _ActionButtonsSection(
                            therapist: therapist,
                            session: widget.session,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: AppPadding.symetricHorizontalOnly,
                    child: AppButton(
                      label: 'Join with ${therapist.nameWithTitle}',
                      isLoading: isStarting,
                      onTap: startSession,
                    ),
                  ),
                ),
    );
  }
}

class _ActionButtonsSection extends StatelessWidget {
  const _ActionButtonsSection({required this.therapist, required this.session});

  final Therapist therapist;
  final Session session;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40.w,
      children: [
        button(
          icon: AppIcons.message,
          onTap: () {
            AppNavigator.to(context, ChatWindowScreen(therapist: therapist, sessionId: session.id));
          },
        ),
        button(
          icon: AppIcons.call,
          onTap: () {
            AppNavigator.to(context, AudioCallScreen(therapist: therapist, sessionId: session.id));
          },
        ),
        button(
          icon: AppIcons.video,
          onTap: () {
            AppNavigator.to(context, VideoCallScreen(therapist: therapist, sessionId: session.id));
          },
        ),
      ],
    );
  }

  Widget button({
    required String icon,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68.h,
        width: 68.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SvgPicture.asset(
            icon,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.cover,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
