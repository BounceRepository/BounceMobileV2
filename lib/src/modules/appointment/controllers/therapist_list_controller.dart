import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/therapist_list_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class TherapistListController extends BaseController {
  final ITherapistListService _therapistListService;

  TherapistListController({required ITherapistListService therapistListService})
      : _therapistListService = therapistListService;

  List<Therapist> _therapists = [];
  List<Therapist> get therapists => _therapists;
  List<Therapist> _topTherapists = [];
  List<Therapist> get topTherapists => _topTherapists;
  List<Therapist> _therapistsNearYou = [];
  List<Therapist> get therapistsNearYou => _therapistsNearYou;

  Future<void> getAllTherapist() async {
    try {
      setIsLoading(true);
      _therapists = await _therapistListService.getAllTherapist();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> getAllTopTherapist() async {
    try {
      setIsLoading(true);
      _topTherapists = await _therapistListService.getAllTopTherapist();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<void> getAllTherapistNearYou() async {
    try {
      setIsLoading(true);
      _therapistsNearYou = await _therapistListService.getAllTherapistNearYou();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
