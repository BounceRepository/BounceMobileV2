import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeCommentServiceImpl implements ICommentService {
  @override
  Future<void> createComment({
    required String comment,
    required int feedId,
  }) async {
    await fakeNetworkDelay();
    throw InternalFailure();
  }

  @override
  Future<void> createReply({
    required String comment,
    required int commentId,
  }) async {
    await fakeNetworkDelay();
  }
}
