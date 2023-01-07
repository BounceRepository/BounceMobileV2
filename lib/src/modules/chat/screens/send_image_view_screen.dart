import 'dart:io';

import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_list_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/widgets/message_input.dart';
import 'package:bounce_patient_app/src/shared/image/controller/image_controller.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SendImageViewScreen extends StatefulWidget {
  const SendImageViewScreen({
    super.key,
    required this.image,
    required this.therapist,
  });

  final File image;
  final Therapist therapist;

  @override
  State<SendImageViewScreen> createState() => _SendImageViewScreenState();
}

class _SendImageViewScreenState extends State<SendImageViewScreen> {
  String? imageStr;
  late final TextEditingController messageController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void init() async {
    final controller = context.read<ImageController>();

    try {
      setState(() => isLoading = true);
      imageStr = await controller.getImageUrl(widget.image);
      setState(() => isLoading = false);
    } on Failure catch (e) {
      setState(() => isLoading = false);
      controller.setFailure(e);
    }
  }

  void sendMessage() async {
    final image = imageStr;
    if (image == null) {
      return;
    }

    final user = AppSession.user;
    if (user == null) {
      return;
    }

    final controller = context.read<ChatController>();
    final newMessage = ChatMessage(
      id: Utils.getGuid(),
      text: messageController.text,
      receiverId: widget.therapist.id,
      senderId: user.id,
      type: MessageType.text,
      file: image,
      createdAt: DateTime.now(),
    );

    try {
      messageController.clear();
      Navigator.pop(context);
      await controller.sendMessage(newMessage);
    } on Failure catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: const [CloseButton(color: Colors.white)],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Consumer<ImageController>(
            builder: (context, controller, _) {
              if (isLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Loading image...',
                        style: AppText.bold500(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }

              final failure = controller.failure;
              if (failure != null) {
                return ErrorView(error: failure, retry: init);
              }

              final image = imageStr;
              if (image == null) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  SizedBox(height: AppPadding.vertical),
                  Expanded(
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
                  SizedBox(height: 40.h),
                  MessageInput(
                    textEditingController: messageController,
                    send: sendMessage,
                    textStyle: AppText.bold300(context).copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    sendButtonColor: Colors.white,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
