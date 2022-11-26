import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';

abstract class IChatService {
  Future<List<ChatMessage>> getAllMessage({required int receiverId});
  Future<void> pushMessage({
    required ChatMessage chatMessage,
    required String connectionId,
  });
}
