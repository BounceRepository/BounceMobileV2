import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class CommentListController extends BaseController {
  final ICommentListService _commentListService;

  CommentListController({required ICommentListService commentListService})
      : _commentListService = commentListService;

  List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  List<Comment> _replies = [];
  List<Comment> get replies => _replies;

  Future<void> getAllComment(int feedId) async {
    try {
      setIsLoading(true);
      _comments = await _commentListService.getAllComment(feedId);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> getAllReply(int feedId) async {
    try {
      setIsLoading(true);
      _replies = await _commentListService.getAllReply(feedId);
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
