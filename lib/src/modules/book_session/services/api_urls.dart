import 'package:bounce_patient_app/src/config/app_config.dart';

class BookAppointmentURLS {
  BookAppointmentURLS._();

  static const bookAppointment = APIURLs.baseURL + '/Patient/BookAppointment';
  static const confirmAppointment = APIURLs.baseURL + '/Patient/ComfirmAppointment';
  static const getAllTherapist = APIURLs.baseURL + '/Patient/GetAllTherapists';
  static const getAllUpComingSession = APIURLs.baseURL + '/Patient/UpComingSessions';
}
