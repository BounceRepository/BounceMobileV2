import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/modules/journal/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class JournalService implements IJournalService {
  final IApi _api;

  JournalService({required IApi api}) : _api = api;

  @override
  Future<void> create({
    required String title,
    required String text,
  }) async {
    var body = {"text": text, "title": title};

    try {
      await _api.post(JournalAPIURLS.create, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> delete(int id) async {
    var url = JournalAPIURLS.delete + '?id=$id';

    try {
      await _api.delete(url: url);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Journal>> getAllJournal() async {
    try {
      final resposne = await _api.get(JournalAPIURLS.getAllJounral);
      final List collection = resposne['data'];
      return collection.map((json) => Journal.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> update(Journal journal) async {
    var body = {"journalId": journal.id, "title": journal.title, "text": journal.content};

    try {
      await _api.patch(JournalAPIURLS.update, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
