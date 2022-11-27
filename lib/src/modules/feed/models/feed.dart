import 'package:bounce_patient_app/src/modules/feed/models/author.dart';

class Feed {
  final int id;
  final Author author;
  final String message;
  final int likesCount;
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
}
