import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class CommentService implements ICommentService {
  final IApi _api;

  CommentService({required IApi api}) : _api = api;

  @override
  Future<void> createComment({
    required String comment,
    required int feedId,
  }) async {
    var body = {"comment": comment, "feedId": feedId, "time": DateTime.now().toIso8601String()};

    try {
      await _api.post(FeedApiURLS.createComment, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> createReply({
    required String comment,
    required int commentId,
  }) async {
    var body = {"text": comment, "commentId": commentId, "time": DateTime.now().toIso8601String()};

    try {
      await _api.post(FeedApiURLS.createReply, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
