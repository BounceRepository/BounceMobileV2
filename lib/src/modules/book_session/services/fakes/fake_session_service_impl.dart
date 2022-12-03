import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeBookAppointmentServiceImpl implements IBookAppointmentService {
  @override
  Future<String> bookSession({
    required SessionType appointmentType,
    required PaymentOption paymentType,
    required int patientId,
    required String reason,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  }) async {
    await fakeNetworkDelay();
    return Utils.getGuid();
  }

  @override
  Future<void> confirmPayment(String trxRef) async {
    await fakeNetworkDelay();
    //throw InternalFailure();
  }

  @override
  Future<void> rescheduleSession({
    required int sessionId,
    required String startTime,
    required String endTime,
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
}
