import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/book_appointment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SessionServiceImpl implements IBookAppointmentService {
  final IApi _api;

  SessionServiceImpl({required IApi api}) : _api = api;

  @override
  Future<String> bookSession({
    required SessionType appointmentType,
    required PaymentOption paymentType,
    required int patientId,
    required String reason,
    required int therapistId,
    required double price,
    required String startTime,
    required DateTime date,
  }) async {
    var body = {
      "appointmentType": appointmentType.name,
      "paymentType": paymentType.name,
      "problemDecription": reason,
      "startTime": startTime,
      "therapistId": therapistId,
      "price": price.toInt(),
      "totalAMount": price.toInt(),
      "availableTime": date.toIso8601String(),
      "date": date.toIso8601String()
    };

    try {
      final response = await _api.post(BookAppointmentURLS.bookAppointment, body: body);
      return response['data']['trxRef'];
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<void> confirmPayment(String trxRef) async {
    var url = BookAppointmentURLS.confirmAppointment + '?TxRef=$trxRef';

    try {
      await _api.post(url, body: '');
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
}
