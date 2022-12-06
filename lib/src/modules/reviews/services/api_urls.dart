import 'package:bounce_patient_app/src/config/app_config.dart';

class ReviewApiURLS {
  ReviewApiURLS._();

  static const create = APIURLs.baseURL + '/Patient/CreateReview';
  static const getTherapistReviewInfo =
      APIURLs.baseURL + '/Patient/GetReviewsByTherapistId';
}
