import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class SessionListController extends BaseController {
  final ISessionListService _sessionListService;

  SessionListController({required ISessionListService sessionListService})
      : _sessionListService = sessionListService;

  List<Session> _upComingSessions = [];
  List<Session> get upComingSessions => _upComingSessions;
  List<Session> _sessions = [];
  List<Session> get sessions => _sessions;
  List<Session> _completedSessions = [];
  List<Session> get completedSessions => _completedSessions;

  Future<void> getUpComingSessions() async {
    reset();
    try {
      setIsLoading(true);
      _upComingSessions = await _sessionListService.getAllUpComing();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> getAllSession() async {
    reset();
    try {
      setIsLoading(true);
      final result = await _sessionListService.getAll();
      _sessions = result;
      _completedSessions = result.where((element) => element.isCompleted).toList();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
