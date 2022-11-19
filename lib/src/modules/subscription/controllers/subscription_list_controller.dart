import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/interfaces/subscription_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class SubscriptionListController extends BaseController {
  final ISubscriptionService _subscriptionService;

  SubscriptionListController({required ISubscriptionService subscriptionService})
      : _subscriptionService = subscriptionService;

  List<Plan> _plans = [];
  List<Plan> get plans => _plans;

  Future<void> getAllPlan() async {
    try {
      setIsLoading(true);
      _plans = await _subscriptionService.getAllPlan();
      setIsLoading(false);
    } on Failure {
      setIsLoading(false);
      rethrow;
    }
  }
}
