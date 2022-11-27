import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';

abstract class ICommentListService {
  Future<List<Comment>> getAllComment(int feedId);
  Future<List<Comment>> getAllReply(int commentId);
}

abstract class ICommentService {
  Future<void> createComment(Comment comment);
  Future<void> createReply(Comment comment);
}
