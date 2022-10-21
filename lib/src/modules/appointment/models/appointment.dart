import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';

enum AppointmentType {
  audio,
  video,
  chat,
}

class Appointment {
  final String id;
  final Therapist therapist;
  final DateTime date;
  final String time;

  Appointment({
    required this.id,
    required this.therapist,
    required this.date,
    required this.time,
  });
}
