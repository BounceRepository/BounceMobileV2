import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class JournalController extends BaseController {
  final IJournalService _journalService;

  JournalController({required IJournalService journalService})
      : _journalService = journalService;

  List<Journal> _journals = [];
  List<Journal> get journals => _journals;

  Future<void> getAllJournal() async {
    reset();
    try {
      _journals = await _journalService.getAllJournal();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> create(Journal journal) async {
    try {
      await _journalService.create(
        text: journal.content,
        title: journal.title,
      );
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> update(Journal journal) async {
    try {
      await _journalService.update(journal);
      final index = journals.indexWhere((element) => element.id == journal.id);
      _journals[index] = journal;
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    try {
      await _journalService.delete(id);
      journals.removeWhere((element) => element.id == id);
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }
}
