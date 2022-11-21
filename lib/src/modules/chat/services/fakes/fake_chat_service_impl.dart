import 'dart:math';

import 'package:bounce_patient_app/src/modules/chat/models/message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/utils/app_constants.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FakeChatServiceImpl implements IChatService {
  @override
  Future<List<Message>> getAllMessage() async {
    await fakeNetworkDelay();
    return List.generate(
        Random().nextInt(50),
        (index) => Message(
              id: Random().nextInt(10),
              text: lorem(paragraphs: 1, words: Random().nextInt(50) + 10),
              sender: Participant(
                id: _getId(),
                firstName: lorem(paragraphs: 1, words: 1),
                lastName: lorem(paragraphs: 1, words: 1),
                image: '',
              ),
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
