import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SessionListServiceImpl implements ISessionListService {
  final IApi _api;

  SessionListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Session>> getAll() async {
    try {
      final response = await _api.get(BookAppointmentURLS.getAllUpComingSession);
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
    try {
      final response = await _api.get(BookAppointmentURLS.getAllUpComingSession);
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
