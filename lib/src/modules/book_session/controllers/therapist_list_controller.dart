import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/therapist_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class TherapistListController extends BaseController {
  final ITherapistListService _therapistListService;

  TherapistListController({required ITherapistListService therapistListService})
      : _therapistListService = therapistListService;

  List<Therapist> _topTherapists = [];
  List<Therapist> get topTherapists => _topTherapists;
  List<Therapist> _therapistsNearYou = [];
  List<Therapist> get therapistsNearYou => _therapistsNearYou;

  Future<void> getAllTopTherapist() async {
    reset();
    try {
      _topTherapists = await _therapistListService.getAllTopTherapist();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllTherapistNearYou() async {
    reset();
    try {
      _therapistsNearYou = await _therapistListService.getAllTherapistNearYou();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }
}
