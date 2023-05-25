import 'package:bounce_patient_app/src/config/app_config.dart';

class SubscriptionApiURLS {
  SubscriptionApiURLS._();

  static String getAllPlan = '${APIURLs.baseURL}/Patient/GetPlans';
  static String subscribeToPlan = '${APIURLs.baseURL}/Patient/SubscribeToPlan';
}
