import 'package:bounce_patient_app/src/modules/feed/models/author.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment {
  final int id;
  final Author author;
  final String message;
  final int replyCount;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.author,
    required this.message,
    required this.replyCount,
    required this.createdAt,
  });

  String get formattedTime {
    final loadedTime = createdAt.toLocal();
    return timeago.format(loadedTime);
  }

  factory Comment.fromJson({
    required Map<String, dynamic> json,
    required bool isReply,
  }) =>
      Comment(
        id: isReply ? json["replyId"] : json["commentId"],
        message: isReply ? json["replyText"] : json["comment"],
        author: Author(
          name: isReply ? json["replyBy"] : json["commentor"],
          profilePicture: isReply ? json["picturePath"] : json["commentorPicture"],
        ),
        createdAt: DateTime.parse(json["time"]),
        replyCount: isReply ? 0 : json["repliesCount"],
      );
}
