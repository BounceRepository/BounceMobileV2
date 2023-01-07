import 'package:bounce_patient_app/src/config/app_config.dart';

class BookAppointmentURLS {
  BookAppointmentURLS._();

  static const bookAppointment = APIURLs.baseURL + '/Patient/BookAppointment';
  static const getOneTherapist = APIURLs.baseURL + '/Therapist/GetTherpaistById';
  static const confirmAppointment = APIURLs.baseURL + '/Patient/ComfirmAppointment';
  static const rescheduleAppointment = APIURLs.baseURL + '/Patient/ReScheduleAppointment';
  static const getAllTherapist = APIURLs.baseURL + '/Patient/GetAllTherapists';
  static const getAllSession = APIURLs.baseURL + '/Patient/UpComingSessions';
  static const getAvailableBookingTimeListForTherapist =
      APIURLs.baseURL + '/Patient/GetAvaialbleBookingTime';
}
