import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class Plan {
  final int id;
  final String title;
  final Color color;
  final List<SubPlan> subPlans;

  Plan({
    required this.id,
    required this.title,
    required this.color,
    required this.subPlans,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as int,
      title: json['name'] as String,
      color: _getColor(json['name']),
      subPlans: List<SubPlan>.from(json["subPlans"]
          .map((x) => SubPlan.fromJson(json: x, parentPlanTitle: json['name']))),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color.value,
      'subPlans': subPlans.map((x) => x.toMap()).toList(),
    };
  }
}

Color _getColor(String name) {
  if (name.toLowerCase() == 'bronze') {
    return AppColors.bronze;
  } else if (name.toLowerCase() == 'sliver') {
    return AppColors.sliver;
  } else if (name.toLowerCase() == 'gold') {
    return AppColors.gold;
  } else {
    return AppColors.primary;
  }
}

class SubPlan {
  final int id;
  final int parentPlanId;
  final String title;
  final String parentPlantitle;
  final int amount;
  final int freeTrialCount;
  final int meditationCount;
  final int therapistCount;

  SubPlan({
    required this.id,
    required this.parentPlanId,
    required this.title,
    required this.parentPlantitle,
    required this.amount,
    required this.freeTrialCount,
    required this.meditationCount,
    required this.therapistCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planId': parentPlanId,
      'title': title,
      'amount': amount,
      'freeTrialCount': freeTrialCount,
      'meditationCount': meditationCount,
      'therapistCount': therapistCount,
    };
  }

  factory SubPlan.fromJson(
      {required Map<String, dynamic> json, required String parentPlanTitle}) {
    return SubPlan(
      id: json['subPlanId'] as int,
      parentPlanId: json['pLanId'] as int,
      title: json['title'] as String,
      parentPlantitle: parentPlanTitle,
      amount: json['cost'] as int,
      freeTrialCount: json['freeTrialCount'] as int,
      meditationCount: json['numberOfMeditation'] as int,
      therapistCount: json['therapistCount'] as int,
    );
  }
}
