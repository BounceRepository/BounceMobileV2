import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/prescription_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final bool isMe;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final type = message.type;

    if (type == MessageType.prescription) {
      return _PresciptionMessage(message: message);
    }

    return _TextMessageBox(isMe: isMe, message: message);
  }
}

class _TextMessageBox extends StatelessWidget {
  const _TextMessageBox({required this.isMe, required this.message});

  final bool isMe;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return _MessageBox(
      isMe: isMe,
      message: message,
      child: Text(
        message.text,
        style: AppText.bold300(context).copyWith(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class _PresciptionMessage extends StatelessWidget {
  const _PresciptionMessage({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final width = 212.w;
    final height = 176.h;
    final prescription = message.precription;

    if (prescription == null) {
      return const SizedBox.shrink();
    }

    return _MessageBox(
      isMe: false,
      message: message,
      child: Column(
        children: [
          Text(
            'Prescription',
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          AppButton(
            label: 'See',
            onTap: () {
              AppNavigator.to(context, PrescriptionScreen(prescription));
            },
          ),
          // CachedNetworkImage(
          //   imageUrl: AppImages.joinSession,
          //   imageBuilder: (context, imageProvider) => Container(
          //     width: width,
          //     height: height,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8.r),
          //       image: DecorationImage(
          //         image: imageProvider,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   width: width,
          //   height: height,
          //   fit: BoxFit.cover,
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
        ],
      ),
    );
  }
}

class _MessageBox extends StatelessWidget {
  const _MessageBox({
    required this.isMe,
    required this.child,
    required this.message,
  });

  final bool isMe;
  final ChatMessage message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(16.r);
    final time = DateTimeUtils.convertDateTimeToAMPM(message.createdAt);
    final contentArea = SizedBox(
      width: 305.w,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: isMe ? 43.w : 0, right: isMe ? 0 : 43.w),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 11.w),
            decoration: BoxDecoration(
              color: isMe
                  ? const Color(0xffF2F2F2).withOpacity(.32)
                  : const Color(0xffFCE7D8).withOpacity(.32),
              borderRadius: BorderRadius.only(
                topLeft: isMe ? radius : const Radius.circular(0),
                topRight: isMe ? const Radius.circular(0) : radius,
                bottomLeft: radius,
                bottomRight: radius,
              ),
            ),
            child: child,
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              time,
              style: AppText.bold400(context).copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
    final participant = message.receiverId;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isMe
          ? [
              contentArea,
              SizedBox(width: 12.w),
              CustomCacheNetworkImage(
                image: AppImages.joinSession,
                size: 40.h,
              ),
              SizedBox(width: AppPadding.horizontal),
            ]
          : [
              SizedBox(width: AppPadding.horizontal),
              CustomCacheNetworkImage(
                image: AppImages.joinSession,
                size: 40.h,
              ),
              SizedBox(width: 12.w),
              contentArea,
            ],
    );
  }
}
