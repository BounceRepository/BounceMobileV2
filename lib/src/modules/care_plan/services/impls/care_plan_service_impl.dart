import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class CarePlanServiceImpl implements ICarePlanService {
  final IApi _api;

  CarePlanServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<Plan>> getAllPlan() async {
    try {
      final response = await _api.get(SubscriptionApiURLS.getAllPlan);
      final List collection = response['data'];
      return collection.map((json) => Plan.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<TransactionRef> choosePlan(SubPlan plan) async {
    var body = {"planId": plan.id};

    try {
      final response = await _api.post(SubscriptionApiURLS.subscribeToPlan, body: body);
      return TransactionRef(value: response['data']['trxRef']);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
