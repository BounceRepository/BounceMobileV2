import 'package:bounce_patient_app/src/modules/chat/models/message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class ChatListController extends BaseController {
  final IChatService _chatService;

  ChatListController({required IChatService chatService}) : _chatService = chatService;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  Future<void> getAllMessage() async {
    try {
      _messages = await _chatService.getAllMessage();
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> send(Message message) async {
    try {
      _messages.add(message);
      notifyListeners();
    } on Failure {
      _messages.removeLast();
      notifyListeners();
      rethrow;
    }
  }
}
