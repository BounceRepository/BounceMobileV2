import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/datetime_helper_functions.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';

class Therapist {
  final int id;
  final String title;
  final String firstName;
  final String lastName;
  final List<String> certifications;
  final List<String> specializations;
  final String desc;
  final String profilePicture;
  final double rating;
  final int experience;
  final String phoneNumber;
  final WorkingHours workingHours;
  final int serviceChargePerHour;
  final int reviews;
  final int patients;

  Therapist({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.certifications,
    required this.specializations,
    required this.desc,
    required this.profilePicture,
    required this.rating,
    required this.experience,
    required this.phoneNumber,
    required this.workingHours,
    required this.serviceChargePerHour,
    required this.reviews,
    required this.patients,
  });

  String get fullName {
    return '$firstName $lastName';
  }

  String get fullNameWithTitle {
    return '$title. $firstName $lastName, ${certifications.join(',').toUpperCase()}'
        .toTitleCase;
  }

  String get specializationList {
    return specializations.join(' • ');
  }
}

class WorkingHours {
  final List<WeekDays> workDays;
  final String startTime;
  final String endTime;

  WorkingHours({
    required this.workDays,
    required this.startTime,
    required this.endTime,
  });

  List<String> get availableTime {
    final startTimeOfDay = DateTimeHelperFunctions.parseTimeOfDay(startTime);
    final endTimeOfDay = DateTimeHelperFunctions.parseTimeOfDay(endTime);
    List<TimeOfDay> _timesInTimeOfDay = [];
    List<String> _timesInAMPM = [];

    for (int i = startTimeOfDay.hour; i <= endTimeOfDay.hour; i++) {
      _timesInTimeOfDay.add(TimeOfDay(hour: i, minute: 0));
    }

    _timesInAMPM = _timesInTimeOfDay
        .map((element) => DateTimeHelperFunctions.convertTimeOfDayToAMPM(element))
        .toList();

    return _timesInAMPM;
  }

  @override
  String toString() {
    final firstDay = workDays.first.name.toTitleCase;
    final lastDay = workDays.last.name.toTitleCase;

    return '$firstDay - $lastDay ($startTime - $endTime)';
  }
}
