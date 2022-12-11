import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';

abstract class IJournalService {
  Future<List<Journal>> getAllJournal();
  Future<void> create({
    required String title,
    required String text,
  });
  Future<void> update(Journal journal);
  Future<void> delete(int id);
}
