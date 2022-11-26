import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';

abstract class IChatService {
  Future<List<ChatMessage>> getAllMessage();
}


