import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';

abstract class ISessionListService {
  Future<List<Session>> getAll();
  Future<List<Session>> getAllUpComing();
}
