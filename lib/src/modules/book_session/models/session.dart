import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';

enum SessionType {
  audio,
  video,
  chat,
}

class Session {
  final int id;
  final int therapistId;
  final String therapistName;
  final String therapistDiscipline;
  final DateTime date;
  final String startTime;
  final bool isCompleted;

  Session({
    required this.id,
    required this.therapistId,
    required this.therapistName,
    required this.therapistDiscipline,
    required this.date,
    required this.startTime,
    required this.isCompleted,
  });

  String get period {
    var endTimeInDateTime = DateTimeUtils.convertAMPMToDateTime(startTime);
    endTimeInDateTime = DateTime(
      endTimeInDateTime.year,
      endTimeInDateTime.month,
      endTimeInDateTime.day,
      endTimeInDateTime.hour + 1,
    );
    final endTime = DateTimeUtils.convertDateTimeToAMPM(endTimeInDateTime);
    return '$startTime - $endTime';
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['sessionId'],
      therapistId: json['therapistId'],
      therapistName: json['therapistFirstName'],
      therapistDiscipline: json['discipline'],
      date: DateTime.parse(json["date"]),
      startTime: DateTimeUtils.convertDateTimeToAMPM(DateTime.parse(json["startTime"])),
      isCompleted: false,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'therapist': therapist.toMap(),
  //     'date': date.millisecondsSinceEpoch,
  //     'startTime': startTime,
  //     'endTime': endTime,
  //     'isCompleted': isCompleted,
  //   };
  // }
}
