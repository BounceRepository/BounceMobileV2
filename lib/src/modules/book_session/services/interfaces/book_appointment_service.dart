import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';

abstract class IBookAppointmentService {
  Future<String> book({
    required SessionType appointmentType,
    required PaymentType paymentType,
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  });
  Future<void> confirmPayment(String trxRef);
}
