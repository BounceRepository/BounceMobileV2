import 'dart:math';

import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeSessionListServiceImpl implements ISessionListService {
  @override
  Future<List<Session>> getAll() async {
    await fakeNetworkDelay();
    return List.generate(
      25,
      (index) => Session(
        id: Utils.getGuid(),
        therapist: therapist,
        date: DateTime.now(),
        startTime: '10:00 AM',
        endTime: '11:00 AM',
        isCompleted: Random().nextBool(),
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
        therapist: therapist,
        date: DateTime.now(),
        startTime: '06:00 PM',
        endTime: '07:00 PM',
        isCompleted: false,
      ),
    );
  }
}
