import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';

abstract class ITherapistListService {
  Future<List<Therapist>> getAllTherapist();
  Future<List<Therapist>> getAllTherapistNearYou();
  Future<List<Therapist>> getAllTopTherapist();
}
