import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';

abstract class ISessionService {
  Future<SessionJoiningDetails> start(int sessionId);
  Future<void> end(int sessionId);
}
