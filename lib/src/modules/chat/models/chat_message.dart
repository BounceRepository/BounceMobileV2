import 'package:bounce_patient_app/src/modules/chat/models/prescription.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
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

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final user = AppSession.user;

    if (user == null) {
      return ChatMessage(
        id: Utils.getGuid(),
        text: json['message'] as String,
        receiverId: json["receieverId"] as int,
        senderId: 0,
        type: json['isPrecription'] ? MessageType.prescription : MessageType.text,
        createdAt: DateTime.parse(json["time"]).toLocal(),
        file: json['files'] != null ? json['files'] as String : null,
      );
    }

    return ChatMessage(
      id: Utils.getGuid(),
      text: json['message'] as String,
      receiverId: json["receieverId"] as int,
      senderId: json["senderId"] ?? user.id,
      type: json['isPrescription'] ? MessageType.prescription : MessageType.text,
      createdAt: DateTime.parse(json["time"]),
      file: json['filePath'] != null ? json['filePath'] as String : null,
    );
  }
}
