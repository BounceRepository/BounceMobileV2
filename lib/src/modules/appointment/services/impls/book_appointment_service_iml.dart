import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/book_appointment_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class BookAppointmentServiceImpl implements IBookAppointmentService {
  final IApi _api;

  BookAppointmentServiceImpl({required IApi api}) : _api = api;

  @override
  Future<String> bookAppointment({
    required AppointmentType appointmentType,
    required PaymentType paymentType,
    required int patientId,
    required String reason,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  }) async {
    var body = {
      "appointmentType": appointmentType.name,
      "patientId": patientId,
      "paymentType": paymentType.name,
      "problemDecription": reason,
      "therapistId": therapistId,
      "price": price,
      "availableTime": time,
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
  Future<void> confirmAppointment(String trxRef) async {
    var url = BookAppointmentURLS.confirmAppointment + '?TxRef=$trxRef';

    try {
      await _api.post(url, body: '');
    } on Failure {
      rethrow;
    }
  }
}
