import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';

abstract class IAppointmentListService {
  Future<List<Appointment>> getAllAppointment();
}
