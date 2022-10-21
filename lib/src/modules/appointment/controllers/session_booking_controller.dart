import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/session_booking_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

class SessionBookingController extends BaseController {
  final ISessionBookingService _sessionBookingService;

  SessionBookingController({required ISessionBookingService sessionBookingService})
      : _sessionBookingService = sessionBookingService;

  DateTime? selectedDate;
  String? reason;
  String? selectedTime;
  String? note;
}
