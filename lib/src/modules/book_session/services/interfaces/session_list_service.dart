import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';

abstract class ISessionListService {
  Future<List<Session>> getAllCompleted();
  Future<List<Session>> getAllUpComing();
}
