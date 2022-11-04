import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SessionListServiceImpl implements ISessionListService {
  final IApi _api;

  SessionListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Session>> getAll() async {
    // TODO: implement getAllAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<Session>> getAllUpComing() async {
    // TODO: implement getAllUpComing
    throw UnimplementedError();
  }
}
