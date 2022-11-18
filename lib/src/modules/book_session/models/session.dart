import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';

enum SessionType {
  audio,
  video,
  chat,
}

class Session {
  final String id;
  final int therapistId;
  final String therapistName;
  final String therapistDiscipline;
  final String date;
  final String startTime;
  final String endTime;
  final bool isCompleted;

  Session({
    required this.id,
    required this.therapistId,
    required this.therapistName,
    required this.therapistDiscipline,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  String get period {
    return '$startTime - $endTime';
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: Utils.getGuid(),
      therapistId: json['therapistId'],
      therapistName: json['therapistName'],
      therapistDiscipline: json['discipline'],
      date: json['date'],
      startTime: json['time'] as String,
      endTime: json['endTime'] as String,
      isCompleted: json['isCompleted'] as bool,
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
