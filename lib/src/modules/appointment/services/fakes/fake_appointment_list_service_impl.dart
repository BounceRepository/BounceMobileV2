import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/appointment_list_service.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/services.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeAppointmentListServiceImpl implements IAppointmentListService {
  @override
  Future<List<Appointment>> getAllAppointment() async {
    await fakeNetworkDelay();
    return List.generate(5, (index) => _appointment);
  }
}

final _appointment = Appointment(
  id: Utils.getGuid(),
  therapist: therapist,
  date: DateTime.now(),
  time: '10:00 AM',
);
