import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/modules/journal/services/interfaces/journal_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class JournalServiceImpl implements IJournalService {
  final IApi _api;

  JournalServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> create(Journal journal) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Journal>> getAllJournal() {
    // TODO: implement getAllJournal
    throw UnimplementedError();
  }

  @override
  Future<void> update(Journal journal) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
