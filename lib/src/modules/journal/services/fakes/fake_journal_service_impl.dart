import 'dart:math';

import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeJournalServiceImpl implements IJournalService {
  @override
  Future<void> create(Journal journal) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> delete(String id) async {
    await fakeNetworkDelay();
  }

  @override
  Future<List<Journal>> getAllJournal() async {
    await fakeNetworkDelay();
    return List.generate(
        4,
        (index) => Journal(
              id: Utils.getGuid(),
              title: lorem(paragraphs: 1, words: Random().nextInt(7) + 3),
              content: lorem(
                  paragraphs: Random().nextInt(5), words: Random().nextInt(70) + 20),
              createdAt: DateTime.now(),
            ));
  }

  @override
  Future<void> update(Journal journal) async {
    await fakeNetworkDelay();
  }
}