enum MessageType {
  text,
  file,
  prescription,
}

class ChatMessage {
  final String id;
  final String text;
  final int receiverId;
  final MessageType type;
  final DateTime createdAt;
  final Precription? precription;

  ChatMessage({
    required this.id,
    required this.text,
    required this.receiverId,
    required this.type,
    required this.createdAt,
    this.precription,
  });
}

class Precription {
  final int id;
  final String? image;
  final String drugName;
  final String dosage;
  final String desc;

  Precription({
    required this.id,
    required this.image,
    required this.drugName,
    required this.dosage,
    required this.desc,
  });
}
