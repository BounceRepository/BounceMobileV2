import 'package:bounce_patient_app/src/config/app_config.dart';

class BookAppointmentURLS {
  BookAppointmentURLS._();

  static String bookAppointment = '${APIURLs.baseURL}/Patient/BookAppointment';
  static String getOneTherapist = '${APIURLs.baseURL}/Therapist/GetTherpaistById';
  static String confirmAppointment = '${APIURLs.baseURL}/Patient/ComfirmAppointment';
  static String rescheduleAppointment = '${APIURLs.baseURL}/Patient/ReScheduleAppointment';
  static String getAllTherapist = '${APIURLs.baseURL}/Therapist/GetAllTherapist';
  static String getAllSession = '${APIURLs.baseURL}/Patient/UpComingSessions';
  static String getAvailableBookingTimeListForTherapist = '${APIURLs.baseURL}/Patient/GetAvaialbleBookingTime';
  static String startSession = '${APIURLs.baseURL}/Communication/StartConsultaion?appointRequestId=';
  static String endSession = '${APIURLs.baseURL}/Communication/EndConsultaion?appointRequestId=';
}
