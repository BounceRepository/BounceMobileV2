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
        '007eJxTYFh9/Pi7yQydqRYettFtzb5PFugvERSz4L2g9XThvfidzVMVGIzN0tJSzY0MjQySLE3MzI0sLU1MLZNNLJJNDQ1SLS2ScjjPJjcEMjI8beljZmSAQBCfnSE5IzEvLzWHgQEAfpcf5w==';
    return SessionJoiningDetails(channel: channel, token: token);
  }
}
