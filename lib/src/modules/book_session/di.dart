import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/book_session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';

void appointmentControllersInit({
  required bool useFake,
}) {
  if (useFake) {
    diContainer.registerFactory(() =>
        TherapistListController(therapistListService: FakeTherapistListServiceImpl()));
    diContainer.registerFactory(() =>
        BookSessionController(sessionBookingService: FakeBookAppointmentServiceImpl()));
    diContainer.registerFactory(() =>
        SessionListController(appointmentListService: FakeAppointmentListServiceImpl()));
  } else {
    diContainer.registerFactory(
        () => TherapistListController(therapistListService: diContainer()));
    diContainer.registerFactory(
        () => BookSessionController(sessionBookingService: diContainer()));
    diContainer.registerFactory(
        () => SessionListController(appointmentListService: diContainer()));
  }
}
