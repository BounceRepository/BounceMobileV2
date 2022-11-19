import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/impls/api_urls.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/interfaces/subscription_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SubscriptionServiceImpl implements ISubscriptionService {
  final IApi _api;

  SubscriptionServiceImpl({required IApi api}) : _api = api;

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
}
