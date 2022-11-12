import 'package:bounce_patient_app/src/modules/chat/models/message.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final bool isMe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    final type = message.type;

    return Container();
  }
}
