import 'dart:math';

import 'package:bounce_patient_app/src/modules/feed/models/author.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/modules/feed/services/interfaces/i_feed_service.dart';
import 'package:bounce_patient_app/src/shared/assets/images.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeFeedListServiceImpl implements IFeedListService {
  @override
  Future<List<Feed>> getAllMyFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }

  @override
  Future<List<Feed>> getAllFamilyFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }

  @override
  Future<List<Feed>> getAllParentingFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }

  @override
  Future<List<Feed>> getAllRelationshipFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }

  @override
  Future<List<Feed>> getAllSelfCareFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }

  @override
  Future<List<Feed>> getAllSexualityFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }

  @override
  Future<List<Feed>> getAllWorkEthnicsFeed() async {
    await fakeNetworkDelay();
    return List.generate(
      Random().nextInt(100) + 10,
      (index) => Feed(
        id: Random().nextInt(10000),
        author: Author(
          name: lorem(paragraphs: 1, words: 2),
          profilePicture: AppImages.joinSession,
        ),
        message: lorem(paragraphs: 1, words: Random().nextInt(60) + 20),
        likesCount: Random().nextInt(10000),
        commentCount: Random().nextInt(1000),
        createdAt: DateTime(
          DateTime.now().year,
          Random().nextInt(12) + 1,
          Random().nextInt(25) + 1,
        ),
        isLikedByMe: Random().nextBool(),
      ),
    );
  }
}
