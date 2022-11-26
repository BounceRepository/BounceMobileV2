import 'package:bounce_patient_app/src/modules/chat/models/prescription.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';

enum MessageType {
  text,
  file,
  prescription,
}

class ChatMessage {
  final String id;
  final String text;
  final int receiverId;
  final int senderId;
  final MessageType type;
  final DateTime createdAt;
  final String? file;
  final Precription? precription;

  ChatMessage({
    required this.id,
    required this.text,
    required this.receiverId,
    required this.senderId,
    required this.type,
    required this.createdAt,
    this.file,
    this.precription,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    final user = AppSession.user;

    if (user == null) {
      return ChatMessage(
        id: Utils.getGuid(),
        text: map['message'] as String,
        receiverId: map["receieverId"] as int,
        senderId: 0,
        type: MessageType.text,
        createdAt: DateTime.parse(map["time"]),
        file: map['files'] != null ? map['files'] as String : null,
      );
    }

    return ChatMessage(
      id: Utils.getGuid(),
      text: map['message'] as String,
      receiverId: map["receieverId"] as int,
      senderId: map["senderId"] ?? user.id,
      type: MessageType.text,
      createdAt: DateTime.parse(map["time"]),
      file: map['files'] != null ? map['files'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'receiverId': receiverId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'file': file,
    };
  }
}
