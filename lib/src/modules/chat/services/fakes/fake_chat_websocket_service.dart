import 'dart:async';

import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:bounce_patient_app/src/shared/utils/utils.dart';

class FakeChatWebsocketService implements IChatWebsocketService {
  final _messageController = StreamController<ChatMessage>();

  @override
  String? getConnectionId() {
    return Utils.getGuid();
  }

  @override
  Stream<ChatMessage> getIncomingMessage() async* {
    yield* _messageController.stream.asBroadcastStream();
  }

  @override
  Future<void> openConnection() async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> sendMessage(ChatMessage chatMessage) async {
    await fakeNetworkDelay();
  }

  @override
  Future<void> closeConnection() async {
    try {} on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
