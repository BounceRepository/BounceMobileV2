import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeBookAppointmentServiceImpl implements IBookAppointmentService {
  @override
  Future<String> book({
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
}
