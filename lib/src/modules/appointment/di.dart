import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/appointment/controllers/session_booking_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/fakes/fake_session_booking_service_impl.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/services.dart';

void appointmentControllersInit({
  required bool initFakeService,
}) {
  if (initFakeService) {
    diContainer.registerFactory(() =>
        TherapistListController(therapistListService: FakeTherapistListServiceImpl()));
    diContainer.registerFactory(() =>
        SessionBookingController(sessionBookingService: FakeSessionBookingServiceImpl()));
  } else {
    diContainer.registerFactory(
        () => TherapistListController(therapistListService: diContainer()));
    diContainer.registerFactory(
        () => SessionBookingController(sessionBookingService: diContainer()));
  }
}
