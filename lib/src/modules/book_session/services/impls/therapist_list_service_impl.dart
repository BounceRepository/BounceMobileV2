import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/therapist_list_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class TherapistListServiceImpl implements ITherapistListService {
  final IApi _api;

  TherapistListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Therapist>> getAllTherapist() async {
    try {
      final response = await _api.get(BookAppointmentURLS.getAllTherapist);
      final List collection = response['data'];
      return collection.map((json) => Therapist.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Therapist>> getAllTherapistNearYou() async {
    try {
      final response = await _api.get(BookAppointmentURLS.getAllTherapist);
      final List collection = response['data'];
      return collection.map((json) => Therapist.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Exception {
      throw InternalFailure();
    } on Error {
      throw InternalFailure();
    }
  }

  @override
  Future<List<Therapist>> getAllTopTherapist() async {
    // TODO: implement getAllTopTherapist
    throw UnimplementedError();
  }
}
