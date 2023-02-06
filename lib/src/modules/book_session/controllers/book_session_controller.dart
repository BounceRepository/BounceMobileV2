import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/book_appointment_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class BookSessionController extends BaseController {
  final IBookSessionService _service;

  BookSessionController({required IBookSessionService sessionBookingService})
      : _service = sessionBookingService;

  DateTime selectedDate = DateTime.now();
  String? reason;
  String? selectedTime;
  String? problemDesc;
  List<String> _availableTimeList = [];
  List<String> get availableTimeList => _availableTimeList;

  void init() {
    reason = null;
    selectedTime = null;
    problemDesc = null;
    selectedDate = DateTime.now();
    _availableTimeList.clear();
  }

  Future<void> bookSession({
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
    String? problemDesc,
  }) async {
    try {
      await _service.bookSession(
        problemDesc: problemDesc,
        reason: reason,
        patientId: patientId,
        therapistId: therapistId,
        price: price,
        startTime: time,
        date: date,
      );
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

  Future<void> getAvailableBookingTimeListForTherapist({
    required int therapistId,
  }) async {
    reset();
    try {
      setIsLoading(true);
      _availableTimeList = await _service.getAvailableBookingTimeListForTherapist(
          therapistId: therapistId, date: selectedDate);
      if (_availableTimeList.isEmpty) {
        throw Failure('Doctor is not available');
      }
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
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
