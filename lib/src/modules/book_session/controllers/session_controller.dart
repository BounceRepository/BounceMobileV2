import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class SessionController extends BaseController {
  final ISessionService _sessionService;

  SessionController({required ISessionService sessionService})
      : _sessionService = sessionService;

  bool _inSession = false;
  bool get inSession => _inSession;
  int? _therapisId;
  int? get therapisId => _therapisId;
  SessionJoiningDetails? _sessionJoiningDetails;
  SessionJoiningDetails? get sessionJoiningDetails => _sessionJoiningDetails;

  Future<void> start({
    required int sessionId,
    required int therapisId,
  }) async {
    try {
      _sessionJoiningDetails = await _sessionService.start(sessionId);
      _inSession = true;
      _therapisId = therapisId;
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> end({required int sessionId}) async {
    try {
      await _sessionService.end(sessionId);
      _inSession = false;
      _therapisId = null;
      _sessionJoiningDetails = null;
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }
}
