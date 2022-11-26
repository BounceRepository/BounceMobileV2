import 'dart:math';

import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeChatServiceImpl implements IChatService {
  @override
  Future<List<ChatMessage>> getAllMessage() async {
    await fakeNetworkDelay();
    return List.generate(
        Random().nextInt(50),
        (index) => ChatMessage(
              id: Utils.getGuid(),
              text: lorem(paragraphs: 1, words: Random().nextInt(50) + 10),
              receiverId: _getId(),
              type: MessageType.text,
              createdAt: DateTime.now(),
            ));
  }
}

int _getId() {
  final user = AppSession.user;

  if (user == null) {
    return Random().nextInt(10);
  }

  if (Random().nextBool()) {
    return user.id;
  } else {
    return Random().nextInt(5);
  }
}
