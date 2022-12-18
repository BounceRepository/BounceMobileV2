import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/book_appointment_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class BookSessionService implements IBookSessionService {
  final IApi _api;

  BookSessionService({required IApi api}) : _api = api;

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
    var body = {
      "problemDecription": problemDesc ?? 'problem description',
      "reasonForTherapy": reason,
      "startTime": startTime,
      "therapistId": therapistId,
      "totalAMount": price,
      "availableTime": date.toIso8601String(),
      "date": date.toIso8601String(),
    };

    try {
      await _api.post(BookAppointmentURLS.bookAppointment, body: body);
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<void> rescheduleSession({
    required int sessionId,
    required String startTime,
    required DateTime date,
  }) async {
    var body = {
      "sessionId": sessionId,
      "startTime": startTime,
      "date": date.toLocal().toIso8601String()
    };

    try {
      await _api.post(BookAppointmentURLS.rescheduleAppointment, body: body);
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<Therapist> getOneTherapist(int id) async {
    var url = BookAppointmentURLS.getOneTherapist + '?id=$id';

    try {
      final response = await _api.get(url);
      return Therapist.fromJson(response['data']);
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<List<String>> getAvailableBookingTimeListForTherapist({
    required int therapistId,
    required DateTime date,
  }) async {
    var url = BookAppointmentURLS.getAvailableBookingTimeListForTherapist +
        '?therapistId=$therapistId&date=${date.toIso8601String()}';

    try {
      final response = await _api.get(url);
      final data = response['data'];
      return List<String>.from(data.map((x) => x));
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }
}
