import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/appointment/controllers/appointment_list_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/controllers/book_appointment_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/fakes/fake_appointment_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/fakes/fake_book_appointment_service_impl.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/services.dart';

void appointmentControllersInit({
  required bool useFake,
}) {
  if (useFake) {
    diContainer.registerFactory(() =>
        TherapistListController(therapistListService: FakeTherapistListServiceImpl()));
    diContainer.registerFactory(() => BookAppointmentController(
        sessionBookingService: FakeBookAppointmentServiceImpl()));
    diContainer.registerFactory(() => AppointmentListController(
        appointmentListService: FakeAppointmentListServiceImpl()));
  } else {
    diContainer.registerFactory(
        () => TherapistListController(therapistListService: diContainer()));
    diContainer.registerFactory(
        () => BookAppointmentController(sessionBookingService: diContainer()));
    diContainer.registerFactory(
        () => AppointmentListController(appointmentListService: diContainer()));
  }
}
