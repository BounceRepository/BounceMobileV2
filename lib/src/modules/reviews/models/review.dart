import 'package:timeago/timeago.dart' as timeago;

class ReviewInfo {
  ReviewInfo({
    required this.totalReviewCount,
    required this.avgReviewRating,
    required this.oneStarPercentage,
    required this.twoStarPercentage,
    required this.threeStarPercentage,
    required this.fourStarPercentage,
    required this.fiveStarPercentage,
    required this.reviews,
  });

  final int totalReviewCount;
  final double avgReviewRating;
  final double oneStarPercentage;
  final double twoStarPercentage;
  final double threeStarPercentage;
  final double fourStarPercentage;
  final double fiveStarPercentage;
  final List<Review> reviews;

  factory ReviewInfo.fromJson(Map<String, dynamic> json) => ReviewInfo(
        totalReviewCount: json["totalReviewCount"],
        avgReviewRating: json["reviewRation"].toDouble(),
        oneStarPercentage: json["oneStarPercentage"].toDouble(),
        twoStarPercentage: json["twoStarPercentage"].toDouble(),
        threeStarPercentage: json["threeStarPercentage"].toDouble(),
        fourStarPercentage: json["fourStarPercentage"].toDouble(),
        fiveStarPercentage: json["fiveStarPercentage"].toDouble(),
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalReviewCount": totalReviewCount,
        "reviewRation": avgReviewRating,
        "oneStarPercentage": oneStarPercentage,
        "twoStarPercentage": twoStarPercentage,
        "threeStarPercentage": threeStarPercentage,
        "fourStarPercentage": fourStarPercentage,
        "fiveStarPercentage": fiveStarPercentage,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Review {
  final int id;
  final String reviewerName;
  final String reviewerProfilePic;
  final String comment;
  final int rating;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.reviewerName,
    required this.reviewerProfilePic,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  String get formattedTime {
    final loadedTime = createdAt.toLocal();
    return timeago.format(loadedTime);
  }

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["reviewId"],
        rating: json["reviewStar"],
        comment: json["reviewComment"],
        reviewerName: json["reviewName"],
        reviewerProfilePic: json["picture"],
        createdAt: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "reviewId": id,
        "reviewStar": rating,
        "reviewComment": comment,
        "reviewName": reviewerName,
        "picture": reviewerProfilePic,
        "time": createdAt.toIso8601String(),
      };
}
