import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/appointment_list_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class AppointmentListServiceImpl implements IAppointmentListService {
  final IApi _api;

  AppointmentListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Appointment>> getAllAppointment() async {
    // TODO: implement getAllAppointment
    throw UnimplementedError();
  }
}
