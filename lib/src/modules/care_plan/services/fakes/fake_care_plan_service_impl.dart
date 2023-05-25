import 'dart:math';

import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/modules/care_plan/services/interfaces/care_plan_service.dart';
import 'package:bounce_patient_app/src/modules/wallet/models/transaction_ref.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeCarePlanService implements ICarePlanService {
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
            id: Random().nextInt(10),
            parentPlanId: Random().nextInt(10),
            title: lorem(paragraphs: 1, words: 1),
            parentPlantitle: lorem(paragraphs: 1, words: 1),
            amount: Random().nextInt(10000) + 1000,
            freeTrialCount: Random().nextInt(7) + 1,
            meditationCount: Random().nextInt(30) + 5,
            therapistCount: Random().nextInt(200) + 10,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> choosePlan(SubPlan plan) async {
    await fakeNetworkDelay();
  }
}
