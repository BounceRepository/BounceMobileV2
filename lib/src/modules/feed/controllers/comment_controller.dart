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
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getReplyList(int commentId) async {
    reset();
    try {
      _replies = await _commentListService.getAllReply(commentId);
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> createComment({
    required String comment,
    required int feedId,
  }) async {
    try {
      await _commentService.createComment(comment: comment, feedId: feedId);
    } on Failure {
      rethrow;
    }
  }

  Future<void> createReply({
    required String comment,
    required int commentId,
  }) async {
    try {
      await _commentService.createReply(
        comment: comment,
        commentId: commentId,
      );
    } on Failure {
      rethrow;
    }
  }
}

class MyCommentController extends CommentController {
  MyCommentController({
    required super.commentService,
    required super.commentListService,
  });
}

class RelationShipCommentController extends CommentController {
  RelationShipCommentController({
    required super.commentService,
    required super.commentListService,
  });
}

class SelfCareCommentController extends CommentController {
  SelfCareCommentController({
    required super.commentService,
    required super.commentListService,
  });
}

class WorkEthnicsCommentController extends CommentController {
  WorkEthnicsCommentController({
    required super.commentService,
    required super.commentListService,
  });
}

class FamilyCommentController extends CommentController {
  FamilyCommentController({
    required super.commentService,
    required super.commentListService,
  });
}

class SexualityCommentController extends CommentController {
  SexualityCommentController({
    required super.commentService,
    required super.commentListService,
  });
}

class ParentingCommentController extends CommentController {
  ParentingCommentController({
    required super.commentService,
    required super.commentListService,
  });
}
