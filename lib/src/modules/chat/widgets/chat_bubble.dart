import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/prescription_screen.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageView(image: message.file, id: message.id),
          message.file == null ? const SizedBox.shrink() : SizedBox(height: 12.h),
          message.text.isEmpty
              ? const SizedBox.shrink()
              : Text(
                  message.text,
                  style: AppText.bold300(context).copyWith(
                    fontSize: 14.sp,
                  ),
                ),
        ],
      ),
    );
  }
}

class _PresciptionMessage extends StatelessWidget {
  const _PresciptionMessage({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final prescription = message.precription;
    final image = message.file;

    if (prescription == null) {
      return const SizedBox.shrink();
    }

    return _MessageBox(
      isMe: true,
      message: message,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription',
            style: AppText.bold300(context).copyWith(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          _ImageView(image: image, id: message.id),
          SizedBox(height: 12.h),
          AppButton(
            label: 'View Details',
            padding: EdgeInsets.symmetric(vertical: 5.h),
            onTap: () {
              AppNavigator.to(context, PrescriptionScreen(prescription));
            },
          ),
        ],
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({required this.image, required this.id});

  final String id;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final width = 235.w;
    final height = 176.h;
    final image = this.image;

    if (image == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        AppNavigator.to(context, ImageViewScreen(image: image, id: id));
      },
      child: InteractiveViewer(
        clipBehavior: Clip.none,
        child: Hero(
          tag: id,
          child: CustomCacheNetworkImage(
            image: image,
            isCirclular: false,
            height: height,
            width: width,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.image, required this.id});

  final String id;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: const [CloseButton(color: Colors.white)],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 80.h),
        child: Hero(
          tag: id,
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            child: CustomCacheNetworkImage(
              image: image,
              isCirclular: false,
              height: 400.h,
              width: double.infinity,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
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
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final profilePicture = user.profilePicture;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isMe
          ? [
              contentArea,
              SizedBox(width: 12.w),
              profilePicture != null
                  ? CustomCacheNetworkImage(
                      image: profilePicture,
                      size: 40.h,
                    )
                  : DefaultAppImage(size: 40.h),
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
