import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/appointment_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';

class AppointmentListController extends BaseController {
  final IAppointmentListService _appointmentListService;

  AppointmentListController({required IAppointmentListService appointmentListService})
      : _appointmentListService = appointmentListService;
}
