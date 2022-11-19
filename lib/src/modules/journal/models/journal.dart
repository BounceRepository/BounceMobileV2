import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:flutter/material.dart';

class Journal {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  Journal({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  String get date {
    final dateFullText = DateTimeHelperFunctions.getDateFullStr(createdAt);
    final timeOfDay = TimeOfDay(hour: createdAt.hour, minute: createdAt.minute);
    final timeInAMPM = DateTimeHelperFunctions.convertTimeOfDayToAMPM(timeOfDay);

    return '$dateFullText $timeInAMPM';
  }
}
