import 'dart:math';

import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/utils.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeSessionListServiceImpl implements ISessionListService {
  @override
  Future<List<Session>> getAll() async {
    await fakeNetworkDelay();
    return List.generate(
      25,
      (index) => Session(
        id: Utils.getGuid(),
        therapistId: Random().nextInt(10),
        date: "Sat, 12 Nov 2022",
        startTime: '10:00 AM',
        isCompleted: Random().nextBool(),
        therapistName: lorem(paragraphs: 1, words: 3),
        therapistDiscipline: lorem(paragraphs: 1, words: 5),
      ),
    );
  }

  @override
  Future<List<Session>> getAllUpComing() async {
    await fakeNetworkDelay();
    return List.generate(
      5,
      (index) => Session(
        id: Utils.getGuid(),
        therapistId: Random().nextInt(10),
        date: "Sat, 12 Nov 2022",
        startTime: '06:00 PM',
        isCompleted: false,
        therapistName: lorem(paragraphs: 1, words: 3),
        therapistDiscipline: lorem(paragraphs: 1, words: 5),
      ),
    );
  }
}
