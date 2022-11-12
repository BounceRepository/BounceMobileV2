import 'package:bounce_patient_app/src/shared/models/user.dart';

enum MessageType {
  text,
  file,
  prescription,
}

class Participant extends User {
  Participant({
    required super.userName,
    required super.firstName,
    required super.lastName,
    required super.id,
    required super.email,
    required super.phone,
    required super.dateOfBirth,
  });
}

class Message {
  final String id;
  final String text;
  final Participant sender;
  final Participant receiver;
  final MessageType type;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.receiver,
    required this.type,
    required this.createdAt,
  });
}
