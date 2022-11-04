import 'package:bounce_patient_app/src/modules/book_session/models/therapist.dart';

enum AppointmentType {
  audio,
  video,
  chat,
}

class Session {
  final String id;
  final Therapist therapist;
  final DateTime date;
  final String time;

  Session({
    required this.id,
    required this.therapist,
    required this.date,
    required this.time,
  });
}
