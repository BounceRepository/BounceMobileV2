import 'dart:math';

import 'package:bounce_patient_app/src/modules/subscription/models/plan.dart';
import 'package:bounce_patient_app/src/modules/subscription/services/interfaces/subscription_service.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeSubscriptionServiceImpl implements ISubscriptionService {
  final colors = [AppColors.bronze, AppColors.sliver, AppColors.gold];

  @override
  Future<List<Plan>> getAllPlan() async {
    await fakeNetworkDelay();
    return List.generate(
      3,
      (index) => Plan(
        id: Random().nextInt(10),
        title: lorem(paragraphs: 1, words: 1),
        color: colors[Random().nextInt(2)],
        subPlans: List.generate(
          2,
          (index) => SubPlan(
            planId: Random().nextInt(10),
            title: lorem(paragraphs: 1, words: 1),
            amount: Random().nextInt(10000) + 1000,
            freeTrialCount: Random().nextInt(7) + 1,
            meditationCount: Random().nextInt(30) + 5,
            therapistCount: Random().nextInt(200) + 10,
          ),
        ),
      ),
    );
  }
}
