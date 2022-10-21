import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/therapist_list_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class TherapistListServiceImpl implements ITherapistListService {
  final IApi _api;

  TherapistListServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Therapist>> getAllTherapist() async {
    // TODO: implement getAllTherapist
    throw UnimplementedError();
  }

  @override
  Future<List<Therapist>> getAllTherapistNearYou() async {
    // TODO: implement getAllTherapistNearYou
    throw UnimplementedError();
  }

  @override
  Future<List<Therapist>> getAllTopTherapist() async {
    // TODO: implement getAllTopTherapist
    throw UnimplementedError();
  }
}
