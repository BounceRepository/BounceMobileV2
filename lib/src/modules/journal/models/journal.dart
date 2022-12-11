import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';
import 'package:flutter/material.dart';

class Journal {
  final int id;
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
    final dateFullText = DateTimeUtils.getDateFullStr(createdAt);
    final timeOfDay = TimeOfDay(hour: createdAt.hour, minute: createdAt.minute);
    final timeInAMPM = DateTimeUtils.convertTimeOfDayToAMPM(timeOfDay);

    return '$dateFullText $timeInAMPM';
  }

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        id: json["journalId"],
        title: json["title"],
        content: json["text"],
        createdAt: DateTime.parse(json["createdTime"]),
    );
}
