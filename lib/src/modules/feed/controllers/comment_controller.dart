import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class CommentController extends BaseController {
  final ICommentService _commentService;

  CommentController({required ICommentService commentService})
      : _commentService = commentService;

  Future<void> createComment(Comment comment) async {
    try {
      setIsLoading(true);
      await _commentService.createComment(comment);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> createReply(Comment comment) async {
    try {
      setIsLoading(true);
      await _commentService.createReply(comment);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
