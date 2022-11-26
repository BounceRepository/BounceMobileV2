import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class ChatListController extends BaseController {
  final IChatService _chatService;
  final IChatWebsocketService _chatWebsocketService;

  ChatListController({
    required IChatService chatService,
    required IChatWebsocketService websocketService,
  })  : _chatService = chatService,
        _chatWebsocketService = websocketService;

  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  Future<void> openConnection() async {
    try {
      final newMessage = await _chatWebsocketService.openConnection();

      if (newMessage != null) {
        _messages.add(newMessage);
        notifyListeners();
      }
    } on Failure {
      rethrow;
    }
  }

  Future<void> getAllMessage() async {
    try {
      _messages = await _chatService.getAllMessage();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> send(ChatMessage chatMessage) async {
    try {
      _messages.add(chatMessage);
      notifyListeners();
      // await _chatWebsocketService.sendMessage(chatMessage);
    } on Failure {
      _messages.removeLast();
      notifyListeners();
      rethrow;
    }
  }
}
