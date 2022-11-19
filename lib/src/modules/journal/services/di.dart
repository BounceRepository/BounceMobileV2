import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/services/fakes/fake_journal_service_impl.dart';
import 'package:bounce_patient_app/src/modules/journal/services/impls/journal_service_impl.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';

void journalControllersInit({
  required bool useFake,
}) {
  if (useFake) {
    diContainer.registerFactory(
        () => JournalController(journalService: FakeJournalServiceImpl()));
  } else {
    diContainer.registerFactory(() => JournalController(journalService: diContainer()));
  }
}

void journalServicesInit() {
  diContainer.registerLazySingleton<IJournalService>(
      () => JournalServiceImpl(api: diContainer()));
}
