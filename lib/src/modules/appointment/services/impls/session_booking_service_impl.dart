import 'package:bounce_patient_app/src/modules/appointment/services/interfaces/session_booking_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class SessionBookingServiceImpl implements ISessionBookingService {
  final IApi _api;

  SessionBookingServiceImpl({required IApi api}) : _api = api;

  @override
  Future<void> bookSession() {
    // TODO: implement bookSession
    throw UnimplementedError();
  }
}
