import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SessionService implements ISessionService {
  final IApi _api;

  SessionService({required IApi api}) : _api = api;

  @override
  Future<void> end(int sessionId) async {
    var url = BookAppointmentURLS.endSession + '$sessionId';

    try {
      await _api.patch(url, body: {});
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<SessionJoiningDetails> start(int sessionId) async {
    var url = BookAppointmentURLS.startSession + '$sessionId';

    try {
      final response = await _api.patch(url, body: {});
      return SessionJoiningDetails.fromJson(response['data']);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
