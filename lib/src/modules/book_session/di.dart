import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/book_session_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/fakes/fake_session_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/impls/session_list_service_impl.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/impls/session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/services.dart';

import 'services/interfaces/session_list_service.dart';

void appointmentControllersInit({
  required bool useFake,
}) {
  if (useFake) {
    diContainer.registerFactory(() => TherapistListController(therapistListService: FakeTherapistListService()));
    diContainer.registerFactory(() => BookSessionController(sessionBookingService: FakeBookAppointmentService()));
    diContainer.registerFactory(() => SessionListController(sessionListService: FakeSessionListService()));
    diContainer.registerFactory(() => SessionController(sessionService: FakeSessionService()));
  } else {
    diContainer.registerFactory(() => TherapistListController(therapistListService: diContainer()));
    diContainer.registerFactory(() => BookSessionController(sessionBookingService: diContainer()));
    diContainer.registerFactory(() => SessionListController(sessionListService: diContainer()));
    diContainer.registerFactory(() => SessionController(sessionService: diContainer()));
  }
}

void appointmentServicesInit() {
  diContainer.registerLazySingleton<ITherapistListService>(() => TherapistListService(api: diContainer()));
  diContainer.registerLazySingleton<IBookSessionService>(() => BookSessionService(api: diContainer()));
  diContainer.registerLazySingleton<ISessionListService>(() => SessionListService(api: diContainer()));
  diContainer.registerLazySingleton<ISessionService>(() => SessionService(api: diContainer()));
}
