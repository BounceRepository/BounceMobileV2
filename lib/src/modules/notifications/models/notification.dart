class NotificationMessage {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  bool isRead;

  NotificationMessage({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'creeatedAt': createdAt.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['creeatedAt'] as int),
      isRead: json['isRead'] as bool,
    );
  }
}
