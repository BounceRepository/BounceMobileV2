import 'package:bounce_patient_app/src/config/app_config.dart';

class JournalAPIURLS {
  JournalAPIURLS._();

  static const create = APIURLs.baseURL + '/Journal/CreateJournal';
  static const getAllJounral = APIURLs.baseURL + '/Journal/GetAllJournals';
  static const update = APIURLs.baseURL + '/Journal/UpdateJournal';
  static const delete = APIURLs.baseURL + '/Journal/DeleteJournal';
}
