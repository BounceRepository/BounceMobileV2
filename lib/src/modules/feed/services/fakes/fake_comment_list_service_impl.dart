import 'dart:math';

import 'package:bounce_patient_app/src/modules/feed/models/author.dart';
import 'package:bounce_patient_app/src/modules/feed/models/comment.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_comment_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeCommentListServiceImpl implements ICommentListService {
  @override
  Future<List<Comment>> getAllComment(int feedId) async {
    await fakeNetworkDelay();
    throw InternalFailure();
    return List.generate(
        Random().nextInt(10) + 2,
        (index) => Comment(
              id: Random().nextInt(100),
              author: Author(
                name: lorem(paragraphs: 1, words: 2),
                profilePicture: AppImages.joinSession,
              ),
              message: lorem(paragraphs: 1, words: Random().nextInt(40) + 10),
              replyCount: Random().nextInt(12),
              createdAt: DateTime(
                DateTime.now().year,
                Random().nextInt(12) + 1,
                Random().nextInt(25) + 1,
              ),
            ));
  }

  @override
  Future<List<Comment>> getAllReply(int commentId) async {
    await fakeNetworkDelay();
    return List.generate(
        Random().nextInt(10) + 2,
        (index) => Comment(
              id: Random().nextInt(100),
              author: Author(
                name: lorem(paragraphs: 1, words: 2),
                profilePicture: AppImages.joinSession,
              ),
              message: lorem(paragraphs: 1, words: Random().nextInt(40) + 10),
              replyCount: Random().nextInt(12),
              createdAt: DateTime(
                DateTime.now().year,
                Random().nextInt(12) + 1,
                Random().nextInt(25) + 1,
              ),
            ));
  }
}
