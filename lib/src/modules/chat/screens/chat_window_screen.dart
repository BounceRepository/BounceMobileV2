import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_list_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/widgets/chat_bubble.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChatWindowScreen extends StatefulWidget {
  const ChatWindowScreen({Key? key, required this.therapist}) : super(key: key);

  final Therapist therapist;

  @override
  State<ChatWindowScreen> createState() => _ChatWindowScreenState();
}

class _ChatWindowScreenState extends State<ChatWindowScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() async {
    setState(() => isLoading = true);
    final controller = context.read<ChatListController>();

    try {
      await controller.openConnection();
      await getAllMessage();
    } on Failure catch (e) {
      setState(() => isLoading = false);
      controller.setFailure(e);
    }
    setState(() => isLoading = false);
  }

  Future<void> getAllMessage() async {
    final controller = context.read<ChatListController>();

    if (controller.messages.isEmpty) {
      try {
        await controller.getAllMessage(receiverId: widget.therapist.id);
      } on Failure {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        label: widget.therapist.fullNameWithTitle,
        centerTitle: false,
        actions: [
          AppBarSvgIcon(
            AppIcons.call,
            onTap: () {},
          ),
          SizedBox(width: 20.w),
          AppBarSvgIcon(
            AppIcons.video,
            onTap: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                isLoading
                    ? const Expanded(child: CustomLoadingIndicator())
                    : _ChatMessageListSection(onRetry: init),
                _MessageInputSection(therapist: widget.therapist),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatMessageListSection extends StatelessWidget {
  const _ChatMessageListSection({Key? key, required this.onRetry}) : super(key: key);

  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return Consumer<ChatListController>(
      builder: (BuildContext context, controller, Widget? child) {
        final error = controller.failure;
        if (error != null) {
          return ErrorScreen(error: error, retry: onRetry);
        }

        if (controller.messages.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                'Start a new message',
                style: AppText.titleStyle(context),
              ),
            ),
          );
        }

        final messages = controller.messages.reversed;
        List<ChatBubble> chatBubbles = [];
        for (var message in messages) {
          final chatBubble = ChatBubble(
            isMe: user.id == message.senderId,
            message: message,
          );
          chatBubbles.add(chatBubble);
        }

        return Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.only(top: 20.h),
            children: chatBubbles,
          ),
        );
      },
    );
  }
}

class _MessageInputSection extends StatefulWidget {
  const _MessageInputSection({required this.therapist});

  final Therapist therapist;

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

  void pickImage() async {}

  void send() async {
    if (_messageController.text.isEmpty) {
      return;
    }

    final user = AppSession.user;
    if (user == null) {
      return;
    }

    if (_messageController.text.isNotEmpty) {
      final controller = context.read<ChatListController>();
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
        await controller.send(newMessage);
      } on Failure catch (e) {
        debugPrint(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ),
          ),
          _button(
            icon: AppIcons.send,
            onTap: send,
          ),
        ],
      ),
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
