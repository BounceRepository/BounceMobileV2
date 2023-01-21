import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SessionListService implements ISessionListService {
  final IApi _api;

  SessionListService({required IApi api}) : _api = api;

  @override
  Future<List<Session>> getAllCompleted() async {
    var url = BookAppointmentURLS.getAllSession + '?filter=completed';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((json) => Session.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Session>> getAllUpComing() async {
    var url = BookAppointmentURLS.getAllSession + '?filter=upcoming';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      final items = collection.map((json) => Session.fromJson(json)).toList();
      return items;
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
