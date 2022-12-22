import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';

abstract class ICarePlanService {
  Future<List<Plan>> getAllPlan();
  Future<void> choosePlan(SubPlan plan);
}
