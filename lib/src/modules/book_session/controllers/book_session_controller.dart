import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/book_appointment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class BookSessionController extends BaseController {
  final IBookAppointmentService _service;

  BookSessionController({required IBookAppointmentService sessionBookingService})
      : _service = sessionBookingService;

  DateTime selectedDate = DateTime.now();
  String? reason;
  String? selectedTime;
  String? note;

  Future<String> bookSession({
    required SessionType appointmentType,
    required PaymentType paymentType,
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  }) async {
    try {
      final trxRef = await _service.book(
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
      await _service.confirmPayment(trxRef);
    } on Failure {
      rethrow;
    }
  }
}
