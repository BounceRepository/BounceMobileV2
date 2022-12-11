import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';

abstract class ICommentListService {
  Future<List<Comment>> getAllComment(int feedId);
  Future<List<Comment>> getAllReply(int commentId);
}

abstract class ICommentService {
  Future<void> createComment({
    required String comment,
    required int feedId,
  });
  Future<void> createReply({
    required String comment,
    required int commentId,
  });
}
