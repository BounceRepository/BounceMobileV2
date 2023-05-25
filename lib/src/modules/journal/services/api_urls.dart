import 'package:bounce_patient_app/src/config/app_config.dart';

class JournalAPIURLS {
  JournalAPIURLS._();

  static String create = '${APIURLs.baseURL}/Journal/CreateJournal';
  static String getAllJounral = '${APIURLs.baseURL}/Journal/GetAllJournals';
  static String update = '${APIURLs.baseURL}/Journal/UpdateJournal';
  static String delete = '${APIURLs.baseURL}/Journal/DeleteJournal';
}
