import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';

abstract class IBookAppointmentService {
  Future<String> bookAppointment({
    required AppointmentType appointmentType,
    required PaymentType paymentType,
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  });
  Future<void> confirmAppointment(String trxRef);
}
