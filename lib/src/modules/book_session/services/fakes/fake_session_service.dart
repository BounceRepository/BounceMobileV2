import 'package:bounce_patient_app/src/modules/book_session/models/session.dart';
import 'package:bounce_patient_app/src/modules/book_session/services/interfaces/session_service.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';

class FakeSessionService implements ISessionService {
  @override
  Future<void> end(int sessionId) async {
    await fakeNetworkDelay();
  }

  @override
  Future<SessionJoiningDetails> start(int sessionId) async {
    await fakeNetworkDelay();
    const channel = 'channel';
    const token =
        '007eJxTYLjyS/KHo/e6h7s59x9PPjLPQ0e5V+fr8Xsd1Wn/It6eCLBUYDA2S0tLNTcyNDJIsjQxMzeytDQxtUw2sUg2NTRItbRImvH+VHJDICPDhQf/GBihEMRnZ0jOSMzLS81hYAAAkR0kMw==';
    return SessionJoiningDetails(channel: channel, token: token);
  }
}
