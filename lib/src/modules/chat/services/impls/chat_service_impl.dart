import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/api_urls.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/network/api_service.dart';

class ChatServiceImpl implements IChatService {
  final IApi _api;

  ChatServiceImpl({required IApi api}) : _api = api;

  @override
  Future<List<ChatMessage>> getAllMessage({required int receiverId}) async {
    var url = ChatApiUrls.getAllChatMessage + '?receiverId=1';

    try {
      final response = await _api.get(url);
      final List collection = response['data'];
      return collection.map((map) => ChatMessage.fromMap(map)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> pushMessage({
    required ChatMessage chatMessage,
    required String connectionId,
  }) async {
    var body = {
      "revceieverId": chatMessage.receiverId,
      "message": chatMessage.text,
      "filePaths": 'chatMessage.file',
      "connectionId": connectionId,
      "time": chatMessage.createdAt.toIso8601String()
    };

    try {
      await _api.post(ChatApiUrls.pushMessage, body: body);
    } on Failure {
      rethrow;
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
