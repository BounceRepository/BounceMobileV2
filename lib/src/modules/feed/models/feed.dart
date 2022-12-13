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

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["feedId"],
        message: json["feed"],
        isLikedByMe: json["likeedByMe"],
        author: Author(
          name: json["creator"],
          profilePicture: json["picturePath"],
        ),
        likesCount: json["likesCount"],
        createdAt: DateTime.parse(json["time"]).toLocal(),
        commentCount: json["commentCount"],
      );
}

class FeedGroup {
  final int id;
  final String name;
  final int tabIndex;

  FeedGroup({
    required this.id,
    required this.name,
    required this.tabIndex,
  });
}

final feedGroups = [
  FeedGroup(
    id: 1,
    name: 'Relationship',
    tabIndex: 0,
  ),
  FeedGroup(
    id: 2,
    name: 'Self Care',
    tabIndex: 1,
  ),
  FeedGroup(
    id: 3,
    name: 'Work Ethics',
    tabIndex: 2,
  ),
  FeedGroup(
    id: 4,
    name: 'Family',
    tabIndex: 3,
  ),
  FeedGroup(
    id: 6,
    name: 'Sexuality',
    tabIndex: 4,
  ),
  FeedGroup(
    id: 7,
    name: 'Parenting',
    tabIndex: 5,
  ),
];
