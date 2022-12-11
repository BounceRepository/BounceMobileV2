import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
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

  void init() {
    reason = null;
    selectedTime = null;
    note = null;
    selectedDate = DateTime.now();
  }

  Future<String> bookSession({
    required SessionType appointmentType,
    required PaymentOption paymentType,
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  }) async {
    try {
      final trxRef = await _service.bookSession(
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

  Future<void> rescheduleAppointment({
    required int sessionId,
    required String startTime,
    required DateTime date,
  }) async {
    try {
      await _service.rescheduleSession(
        sessionId: sessionId,
        startTime: startTime,
        date: date,
      );
    } on Failure {
      rethrow;
    }
  }

  Future<Therapist> getOneTherapist(int therapistId) async {
    reset();
    try {
      setIsLoading(true);
      final result = await _service.getOneTherapist(therapistId);
      setIsLoading(false);
      return result;
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
