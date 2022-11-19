import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';

abstract class ISubscriptionService {
  Future<List<Plan>> getAllPlan();
}
