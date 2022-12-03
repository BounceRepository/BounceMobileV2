class NotificationMessage {
  final int id;
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
      'notificationId': id,
      'title': title,
      'message': body,
      'time': createdAt.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      id: json['notificationId'] as int,
      title: json['title'] as String,
      body: json['message'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['time'] as int),
      isRead: json['isNewNotification'] as bool,
    );
  }
}
