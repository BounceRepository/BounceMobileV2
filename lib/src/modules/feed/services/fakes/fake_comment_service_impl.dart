import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeCommentServiceImpl implements ICommentService {
  @override
  Future<void> createComment(Comment comment) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> createReply(Comment comment) async {
    await fakeNetworkDelay();
  }
}
