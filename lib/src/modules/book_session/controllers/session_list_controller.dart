import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

class SessionListController extends BaseController {
  final ISessionListService _appointmentListService;

  SessionListController({required ISessionListService appointmentListService})
      : _appointmentListService = appointmentListService;
}
