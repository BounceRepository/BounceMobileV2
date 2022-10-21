import 'package:bounce_patient_app/src/modules/appointment/models/appointment.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/services.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/payment.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeBookAppointmentServiceImpl implements IBookAppointmentService {
  @override
  Future<String> bookAppointment({
    required AppointmentType appointmentType,
    required PaymentType paymentType,
    required int patientId,
    required String reason,
    required int therapistId,
    required double price,
    required String time,
    required DateTime date,
  }) async {
    await Future.delayed(fakeNetworkDelay);
    return HelperFunctions.generateUniqueId();
  }

  @override
  Future<void> confirmAppointment(String trxRef) async {
    await Future.delayed(fakeNetworkDelay);
    //throw InternalFailure();
  }
}
