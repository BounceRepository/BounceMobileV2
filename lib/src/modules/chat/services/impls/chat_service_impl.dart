import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class ChatServiceImpl implements IChatService {
  final IApi _api;

  ChatServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<ChatMessage>> getAllMessage() async {
    // TODO: implement getAllMessage
    throw UnimplementedError();
  }
}
