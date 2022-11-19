import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';

abstract class IJournalService {
  Future<List<Journal>> getAllJournal();
  Future<void> create(Journal journal);
  Future<void> update(Journal journal);
  Future<void> delete(String id);
}
