import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeAppointmentListServiceImpl implements ISessionListService {
  @override
  Future<List<Session>> getAllSession() async {
    await fakeNetworkDelay();
    return List.generate(5, (index) => _appointment);
  }
}

final _appointment = Session(
  id: Utils.getGuid(),
  therapist: therapist,
  date: DateTime.now(),
  time: '10:00 AM',
);
