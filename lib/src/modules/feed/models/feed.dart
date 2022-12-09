import 'package:bounce_patient_app/src/modules/feed/models/author.dart';
import 'package:timeago/timeago.dart' as timeago;

class Feed {
  final int id;
  final Author author;
  final String message;
  final int commentCount;
  final DateTime createdAt;
  int likesCount;
  bool isLikedByMe;

  Feed({
    required this.id,
    required this.author,
    required this.message,
    required this.commentCount,
    required this.createdAt,
    required this.likesCount,
    required this.isLikedByMe,
  });

  String get formattedTime {
    final loadedTime = createdAt.toLocal();
    return timeago.format(loadedTime);
  }
}
