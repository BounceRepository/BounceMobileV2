import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';

enum SessionType {
  audio,
  video,
  chat,
}

class Session {
  final String id;
  final Therapist therapist;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isCompleted;

  Session({
    required this.id,
    required this.therapist,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  String get period {
    return '$startTime - $endTime';
  }
}
