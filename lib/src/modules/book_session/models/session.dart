import 'package:bounce_patient_app/src/shared/utils/datetime_utils.dart';

enum SessionType { audio, video, chat }

class Session {
  final int id;
  final int therapistId;
  final String therapistName;
  final String therapistDiscipline;
  final DateTime date;
  final String startTime;
  final bool isCompleted;
  final bool isDue;
  final bool isOverDue;

  Session({
    required this.id,
    required this.therapistId,
    required this.therapistName,
    required this.therapistDiscipline,
    required this.date,
    required this.startTime,
    required this.isCompleted,
    required this.isDue,
    required this.isOverDue,
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
      date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
      startTime: json["startTime"],
      isCompleted: _getStatus(json["status"]),
      isDue: json["isDue"],
      isOverDue: json["isOverdue"],
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

bool _getStatus(String s) {
  if (s.toLowerCase() == 'completed') {
    return true;
  }

  return false;
}

class SessionJoiningDetails {
  final String channel;
  final String token;

  SessionJoiningDetails({
    required this.channel,
    required this.token,
  });

  factory SessionJoiningDetails.fromJson(Map<String, dynamic> json) =>
      SessionJoiningDetails(
        channel: json["channeName"],
        token: json["channelToken"],
      );

  Map<String, dynamic> toJson() => {
        "channelToken": channel,
        "channeName": token,
      };
}
