import 'package:bounce_patient_app/src/config/app_config.dart';

class FeedApiURLS {
  FeedApiURLS._();

  static const likeFeed = APIURLs.baseURL + '/Notification/LikeFeed';
  // Feed
  static const createFeed = APIURLs.baseURL + '/Notification/CreateNewFeed';
  static const getAllFeed = APIURLs.baseURL + '/Notification/GetAllFeedsGroupById';

  // comment
  static const createComment = APIURLs.baseURL + '/Notification/CreateComment';
  static const getAllCommentForFeed =
      APIURLs.baseURL + '/Notification/GetCommentsByFeedId';

  // reply
  static const createReply = APIURLs.baseURL + '/Notification/CreateReplyOnComment';
  static const getAllReplyForComment =
      APIURLs.baseURL + '/Notification/GetReplyByCommentId';
}
