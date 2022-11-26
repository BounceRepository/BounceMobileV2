import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';

abstract class IChatWebsocketService {
  Future<void> openConnection();
  Future<void> sendMessage(ChatMessage chatMessage);
  Stream<ChatMessage> getIncomingMessage();
  String? getConnectionId();
}
