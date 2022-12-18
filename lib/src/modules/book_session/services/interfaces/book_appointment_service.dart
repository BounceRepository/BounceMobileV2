import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';

abstract class IBookSessionService {
  Future<void> bookSession({
    required String reason,
    required int patientId,
    required int therapistId,
    required double price,
    required String startTime,
    required DateTime date,
     String? problemDesc,
  });
  Future<void> rescheduleSession({
    required int sessionId,
    required String startTime,
    required DateTime date,
  });
  Future<List<String>> getAvailableBookingTimeListForTherapist({
    required int therapistId,
    required DateTime date,
  });
  Future<Therapist> getOneTherapist(int id);
}
