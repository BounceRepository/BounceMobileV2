import 'package:bounce_patient_app/src/config/app_config.dart';

class ReviewApiURLS {
  ReviewApiURLS._();

  static String create = '${APIURLs.baseURL}/Patient/CreateReview';
  static String getTherapistReviewInfo = '${APIURLs.baseURL}/Patient/GetReviewsByTherapistId';
}
