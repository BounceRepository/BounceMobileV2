import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class CommentListService implements ICommentListService {
  final IApi _api;

  CommentListService({required IApi api}) : _api = api;

  @override
  Future<List<Comment>> getAllComment(int feedId) async {
    var url = FeedApiURLS.getAllCommentForFeed + '?feedId=$feedId';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection
          .map((json) => Comment.fromJson(
                json: json,
                isReply: false,
              ))
          .toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Comment>> getAllReply(int commentId) async {
    var url = FeedApiURLS.getAllReplyForComment + '?commentId=$commentId';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection
          .map((json) => Comment.fromJson(
                json: json,
                isReply: true,
              ))
          .toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
