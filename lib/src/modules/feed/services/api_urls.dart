import 'package:bounce_patient_app/src/config/app_config.dart';

class FeedApiURLS {
  FeedApiURLS._();

  static String likeFeed = '${APIURLs.baseURL}/Notification/LikeFeed';
  // Feed
  static String createFeed = '${APIURLs.baseURL}/Notification/CreateNewFeed';
  static String getAllFeed = '${APIURLs.baseURL}/Notification/GetAllFeedsGroupById';

  // comment
  static String createComment = '${APIURLs.baseURL}/Notification/CreateComment';
  static String getAllCommentForFeed = '${APIURLs.baseURL}/Notification/GetCommentsByFeedId';

  // reply
  static String createReply = '${APIURLs.baseURL}/Notification/CreateReplyOnComment';
  static String getAllReplyForComment = '${APIURLs.baseURL}/Notification/GetReplyByCommentId';
}
