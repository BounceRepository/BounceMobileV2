import 'package:bounce_patient_app/src/shared/extensions/string.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class Therapist {
  final int id;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> certifications;
  final String specializations;
  final String about;
  final String profilePicture;
  final double rating;
  final int experience;
  final String phoneNumber;
  final WorkingHours workingHours;
  final int serviceChargePerHour;
  final int reviewCount;
  final int patientCount;

  Therapist({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.certifications,
    required this.specializations,
    required this.about,
    required this.profilePicture,
    required this.rating,
    required this.experience,
    required this.phoneNumber,
    required this.workingHours,
    required this.serviceChargePerHour,
    required this.reviewCount,
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
    return specializations;
  }

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      id: json['therapistId'] as int,
      title: json["title"],
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['emailAddress'],
      phoneNumber: json['phoneNUmber'] as String,
      profilePicture: json['profilePicture'] as String,
      about: json['aboutMe'] as String,
      specializations: json['specialization'],
      // specializations: List<String>.from(json["specialization"].map((x) => x)),
      //certifications: List<String>.from((map['certifications'] as List<String>)),
      certifications: ['PHD'],
      experience: json['yearsOfExperience'],
      workingHours: WorkingHours.fromJson(
        workDays: List<String>.from(json["consultationDays"].map((x) => x)),
        startTime: json['consultationStartTime'],
        endTime: json['consultationEndTime'],
      ),
      serviceChargePerHour: json['serviceChargePerHoure'],
      rating: json['reviewRatio'],
      reviewCount: json['reviewCount'],
      patientCount: json['numberOfPatient'] as int,
    );
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
