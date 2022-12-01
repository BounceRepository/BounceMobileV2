import 'package:bounce_patient_app/src/modules/feed/models/author.dart';
import 'package:timeago/timeago.dart' as timeago;

class Feed {
  final int id;
  final Author author;
  final String message;
  int likesCount;
  final int commentCount;
  final DateTime createdAt;

  Feed({
    required this.id,
    required this.author,
    required this.message,
    required this.likesCount,
    required this.commentCount,
    required this.createdAt,
  });

  String get formattedTime {
    final loadedTime = createdAt.toLocal();
    return timeago.format(loadedTime);
  }
}
