enum MessageType {
  text,
  file,
  prescription,
}

class Participant {
  final int id;
  final String firstName;
  final String lastName;
  final String image;

  Participant({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });
}

class Message {
  final int id;
  final String text;
  final Participant sender;
  final MessageType type;
  final DateTime createdAt;
  final Precription? precription;

  Message({
    required this.id,
    required this.text,
    required this.sender,
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
