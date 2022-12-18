import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeBookAppointmentServiceImpl implements IBookSessionService {
  @override
  Future<void> bookSession({
    required int patientId,
    required String reason,
    required int therapistId,
    required double price,
    required String startTime,
    required DateTime date,
     String? problemDesc,
  }) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> rescheduleSession({
    required int sessionId,
    required String startTime,
    required DateTime date,
  }) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
  }

  @override
  Future<Therapist> getOneTherapist(int id) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
    return therapist;
  }

  @override
  Future<List<String>> getAvailableBookingTimeListForTherapist({
    required int therapistId,
    required DateTime date,
  }) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
    final list = [
      '8:00 AM',
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '4:00 PM',
      '5:00 PM',
      '6:00 PM',
    ];
    list.shuffle();
    return list;
  }
}
