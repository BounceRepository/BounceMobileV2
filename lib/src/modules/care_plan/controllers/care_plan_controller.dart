import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class CarePlanController extends BaseController {
  final ICarePlanService _carePlanService;

  CarePlanController({required ICarePlanService subscriptionService})
      : _carePlanService = subscriptionService;

  List<Plan> _plans = [];
  List<Plan> get plans => _plans;

  Future<void> getAllPlan() async {
    reset();
    try {
      setIsLoading(true);
      _plans = await _carePlanService.getAllPlan();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<TransactionRef> subscribeToPlan(SubPlan plan) async {
    try {
      final result = await _carePlanService.choosePlan(plan);
      return result;
    } on Failure {
      rethrow;
    }
  }
}
