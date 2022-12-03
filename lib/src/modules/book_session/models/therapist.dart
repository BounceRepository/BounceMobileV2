import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';
import 'package:flutter/material.dart';

import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

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
  final int patientCount;

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
    required this.patientCount,
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

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      id: json['therapistId'] as int,
      title: 'Dr',
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      desc: json['about'] as String,
      specializations: [json['specialization']],
      // specializations: List<String>.from(json["specialization"].map((x) => x)),
      //certifications: List<String>.from((map['certifications'] as List<String>)),
      certifications: ['PHD'],
      // certifications: [json['descipline']],
      profilePicture: json['picturePath'] as String,
      rating: json['ratings'].toDouble(),
      experience: int.parse(json['yearsExperience']),
      phoneNumber: json['phoneNUmber'] as String,
      workingHours: WorkingHours.fromJson(
        //workDays: List<String>.from(json["listofDays"].map((x) => x)),
        workDays: ['Monday', 'Tuesday', 'Friday'],
        startTime: json['startTime'],
        endTime: json['endTime'],
      ),
      serviceChargePerHour: json['serviceChargePerHoure'],
      reviews: 10,
      //reviews: json['revew'] as int,
      patientCount: json['numberOfPatient'] as int,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'title': title,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'certifications': certifications,
  //     'specializations': specializations,
  //     'desc': desc,
  //     'profilePicture': profilePicture,
  //     'rating': rating,
  //     'experience': experience,
  //     'phoneNumber': phoneNumber,
  //     'workingHours': workingHours.toMap(),
  //     'serviceChargePerHour': serviceChargePerHour,
  //     'reviews': reviews,
  //     'patients': patients,
  //   };
  // }
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

  factory WorkingHours.fromJson({
    required List<String> workDays,
    required String startTime,
    required String endTime,
  }) {
    return WorkingHours(
      workDays: _getWorkDays(workDays),
      startTime: startTime,
      endTime: endTime,
    );
  }

  List<String> get availableTime {
    var startTimeOfDay = DateTimeUtils.convertAMPMToTimeOfDay(startTime);
    final endTimeOfDay = DateTimeUtils.convertAMPMToTimeOfDay(endTime);
    List<TimeOfDay> _timesInTimeOfDay = [];

    if (startTimeOfDay.hour < endTimeOfDay.hour) {
      for (int i = startTimeOfDay.hour; i <= endTimeOfDay.hour; i++) {
        _timesInTimeOfDay.add(TimeOfDay(hour: i, minute: 0));
      }

      return _timesInTimeOfDay
          .map((element) => DateTimeUtils.convertTimeOfDayToAMPM(element))
          .toList();
    } else {
      for (int i = endTimeOfDay.hour; i <= startTimeOfDay.hour; i++) {
        _timesInTimeOfDay.add(TimeOfDay(hour: i, minute: 0));
      }

      return _timesInTimeOfDay
          .map((element) => DateTimeUtils.convertTimeOfDayToAMPM(element))
          .toList();
    }

    // return _timesInTimeOfDay
    //     .map((element) => DateTimeUtils.convertTimeOfDayToAMPM(element))
    //     .toList();
  }

  @override
  String toString() {
    final firstDay = workDays.first.name.toTitleCase;
    final lastDay = workDays.last.name.toTitleCase;

    return '$firstDay - $lastDay ($startTime - $endTime)';
  }
}

List<WeekDays> _getWorkDays(List<String> workDaysStr) {
  final List<WeekDays> weekdays = [];

  for (int i = 0; i < workDaysStr.length; i++) {
    final day = workDaysStr[i].toLowerCase();

    if (day == WeekDays.monday.name.toLowerCase()) {
      weekdays.add(WeekDays.monday);
      continue;
    } else if (day == WeekDays.tuesday.name.toLowerCase()) {
      weekdays.add(WeekDays.tuesday);
      continue;
    } else if (day == WeekDays.wednesday.name.toLowerCase()) {
      weekdays.add(WeekDays.wednesday);
      continue;
    } else if (day == WeekDays.thursday.name.toLowerCase()) {
      weekdays.add(WeekDays.thursday);
      continue;
    } else if (day == WeekDays.friday.name.toLowerCase()) {
      weekdays.add(WeekDays.friday);
      continue;
    } else if (day == WeekDays.saturday.name.toLowerCase()) {
      weekdays.add(WeekDays.saturday);
      continue;
    } else if (day == WeekDays.sunday.name.toLowerCase()) {
      weekdays.add(WeekDays.sunday);
      continue;
    }
  }

  return weekdays;
}
