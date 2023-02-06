import 'dart:io';

import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/screens/end_session_prompt_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/send_image_view_screen.dart';
import 'package:bounce_patient_app/src/modules/chat/screens/video_call_screen.dart';
import 'package:bounce_patient_app/src/modules/chat/widgets/chat_bubble.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChatWindowScreen extends StatefulWidget {
  const ChatWindowScreen({
    Key? key,
    required this.therapist,
    this.sessionId,
    this.closed = false,
  }) : super(key: key);

  final Therapist therapist;
  final int? sessionId;
  final bool closed;

  @override
  State<ChatWindowScreen> createState() => _ChatWindowScreenState();
}

class _ChatWindowScreenState extends State<ChatWindowScreen> {
  bool isLoading = false;
  Failure? failure;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    setState(() => isLoading = true);
    final inSession = context.read<SessionController>().inSession;

    try {
      if (inSession) {
        final controller = context.read<ChatController>();
        final isConnected = controller.isConnected;

        if (isConnected) {
          if (controller.messages.isEmpty) {
            await getAllMessage();
          }
        } else {
          await startConnection();
          await getAllMessage();
        }
      } else {
        await getAllMessage();
      }
    } on Failure catch (e) {
      failure = e;
    }

    setState(() => isLoading = false);
  }

  Future<void> startConnection() async {
    try {
      await context.read<ChatController>().startConnection();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllMessage() async {
    final controller = context.read<ChatController>();

    try {
      await controller.getAllMessage(receiverId: widget.therapist.id);
    } on Failure {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        label: widget.therapist.fullNameWithTitle,
        centerTitle: false,
        actions: widget.closed
            ? []
            : widget.sessionId == null
                ? []
                : [
                    AppBarSvgIcon(
                      AppIcons.video,
                      onTap: () {
                        AppNavigator.to(
                            context,
                            VideoCallScreen(
                              sessionId: widget.sessionId!,
                              therapist: widget.therapist,
                            ));
                      },
                    ),
                  ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              isLoading
                  ? const Expanded(child: CustomLoadingIndicator())
                  : _ChatMessageListSection(
                      therapist: widget.therapist,
                      onRetry: init,
                      failure: failure,
                      isClosed: widget.closed,
                    ),
              _EndSessionView(sessionId: widget.sessionId, therapist: widget.therapist),
              _MessageInputSection(therapist: widget.therapist, closed: widget.closed),
            ],
          ),
        ),
      ),
    );
  }
}

class _EndSessionView extends StatelessWidget {
  const _EndSessionView({required this.sessionId, required this.therapist});

  final int? sessionId;
  final Therapist therapist;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();

    if (controller.isLoading) {
      return const SizedBox.shrink();
    }

    final sessionId = this.sessionId;

    if (sessionId == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.horizontal,
        right: AppPadding.horizontal,
        bottom: 20.h,
      ),
      child: AppButton(
        label: 'End Session',
        onTap: () {
          endSessionPrompt(
            context: context,
            sessionId: sessionId,
            therapist: therapist,
            isCallSession: false,
          );
        },
      ),
    );
  }
}

class _ChatMessageListSection extends StatelessWidget {
  const _ChatMessageListSection({
    Key? key,
    required this.therapist,
    required this.onRetry,
    required this.failure,
    required this.isClosed,
  }) : super(key: key);

  final Function() onRetry;
  final Therapist therapist;
  final Failure? failure;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Consumer<ChatController>(
        builder: (BuildContext context, controller, Widget? child) {
          final error = failure;
          if (error != null) {
            return ErrorScreen(error: error, retry: onRetry);
          }

          if (controller.messages.isEmpty) {
            String msg = 'Start a new message';

            if (isClosed) {
              msg =
                  'You do not have any old mesaages with ${therapist.fullNameWithTitle}';
            }

            return Center(
              child: Padding(
                padding: AppPadding.symetricHorizontalOnly,
                child: Text(
                  msg,
                  style: AppText.titleStyle(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final messages = controller.messages.reversed;
          List<ChatBubble> chatBubbles = [];
          for (var message in messages) {
            final chatBubble = ChatBubble(
              isMe: user.id != message.receiverId,
              message: message,
              therapist: therapist,
            );
            chatBubbles.add(chatBubble);
          }

          return ListView(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.only(top: 20.h),
            children: chatBubbles,
          );
        },
      ),
    );
  }
}

class _MessageInputSection extends StatefulWidget {
  const _MessageInputSection({required this.therapist, required this.closed});

  final Therapist therapist;
  final bool closed;

  @override
  State<_MessageInputSection> createState() => _MessageInputSectionState();
}

class _MessageInputSectionState extends State<_MessageInputSection> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void pickImage() async {
    final result = await pickImageBottomSheet(context: context);

    if (result != null) {
      final imageFile = result as File;
      if (!mounted) return;
      AppNavigator.to(
          context, SendImageViewScreen(image: imageFile, therapist: widget.therapist));
    }
  }

  void send() async {
    if (_messageController.text.isEmpty) {
      return;
    }

    final user = AppSession.user;
    if (user == null) {
      return;
    }

    if (_messageController.text.isNotEmpty) {
      final controller = context.read<ChatController>();
      final newMessage = ChatMessage(
        id: Utils.getGuid(),
        text: _messageController.text,
        receiverId: widget.therapist.id,
        senderId: user.id,
        type: MessageType.text,
        createdAt: DateTime.now(),
      );

      try {
        _messageController.clear();
        await controller.sendMessage(newMessage);
      } on Failure catch (e) {
        debugPrint(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final therapist = widget.therapist.nameWithTitle;
    final controller = context.watch<ChatController>();
    final messages = controller.messages;

    if (controller.isLoading) {
      return const SizedBox.shrink();
    }

    if (widget.closed && messages.isEmpty) {
      return const SizedBox.shrink();
    }

    if (widget.closed && messages.isNotEmpty) {
      return Container(
        padding: EdgeInsets.only(
          top: 16.h,
          right: AppPadding.horizontal,
          left: AppPadding.horizontal,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: AppColors.boxshadow4,
        ),
        child: SafeArea(
          child: Text(
            'Your consultation session with $therapist has been completed and is now closed.',
            textAlign: TextAlign.center,
            style: AppText.bold400(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Container(
        margin: AppPadding.symetricHorizontalOnly,
        decoration: BoxDecoration(
          color: const Color(0xffFCE7D8).withOpacity(.32),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            _button(
              icon: AppIcons.camera,
              onTap: pickImage,
            ),
            Flexible(
              child: TextField(
                minLines: 1,
                maxLines: 5,
                style: AppText.bold300(context).copyWith(
                  fontSize: 14.sp,
                ),
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 15.w),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
                onSubmitted: (value) => send(),
              ),
            ),
            _button(
              icon: AppIcons.send,
              onTap: send,
            ),
          ],
        ),
      ),
    );
  }

  Widget container({required Widget child}) {
    return Container(
      margin: AppPadding.symetricHorizontalOnly,
      decoration: BoxDecoration(
        color: const Color(0xffFCE7D8).withOpacity(.32),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _button({
    required String icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100.r),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: SvgPicture.asset(
          icon,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
