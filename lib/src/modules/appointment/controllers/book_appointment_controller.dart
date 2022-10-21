import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/book_appointment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class BookAppointmentController extends BaseController {
  final IBookAppointmentService _service;

  BookAppointmentController({required IBookAppointmentService sessionBookingService})
      : _service = sessionBookingService;

  DateTime? selectedDate;
  String? reason;
  String? selectedTime;
  String? note;

  Future<String> bookAppointment({
    required AppointmentType appointmentType,
    required PaymentType paymentType,
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  }) async {
    try {
      final trxRef = await _service.bookAppointment(
        appointmentType: appointmentType,
        paymentType: paymentType,
        reason: reason,
        patientId: patientId,
        therapistId: therapistId,
        price: price,
        time: time,
        date: date,
      );

      return trxRef;
    } on Failure {
      rethrow;
    }
  }

  Future<void> confirmAppointment(String trxRef) async {
    try {
      await _service.confirmAppointment(trxRef);
    } on Failure {
      rethrow;
    }
  }
}
