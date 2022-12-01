import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

abstract class CommentController extends BaseController {
  final ICommentService _commentService;
  final ICommentListService _commentListService;

  CommentController(
      {required ICommentService commentService,
      required ICommentListService commentListService})
      : _commentService = commentService,
        _commentListService = commentListService;

  List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  List<Comment> _replies = [];
  List<Comment> get replies => _replies;

  Future<void> getCommentList(int feedId) async {
    reset();
    try {
      _comments = await _commentListService.getAllComment(feedId);
    } on Failure {
      rethrow;
    }
  }

  Future<void> getReplyList(int feedId) async {
    reset();
    try {
      _replies = await _commentListService.getAllReply(feedId);
    } on Failure {
      rethrow;
    }
  }

  Future<void> createComment(Comment comment) async {
    try {
      await _commentService.createComment(comment);
    } on Failure {
      rethrow;
    }
  }

  Future<void> createReply(Comment comment) async {
    try {
      await _commentService.createReply(comment);
    } on Failure {
      rethrow;
    }
  }
}

class TrendingCommentController extends CommentController {
  TrendingCommentController({
    required super.commentService,
    required super.commentListService,
  });
}
