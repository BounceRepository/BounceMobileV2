import 'dart:developer';

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

  String? _connectionId;
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  Future<void> openConnection() async {
    reset();
    try {
      await _chatWebsocketService.openConnection();
      _getConnectionId();
      await _listenForIncomingMessage();
    } on Failure {
      rethrow;
    }
  }

  void _getConnectionId() {
    _connectionId = _chatWebsocketService.getConnectionId();
  }

  Future<void> _listenForIncomingMessage() async {
    _chatWebsocketService.getIncomingMessage().listen((newChatMessage) {
      try {
        _messages.add(newChatMessage);
        notifyListeners();
      } on Failure {
        rethrow;
      }
    }).onError((err) {
      log(err.toString());
    });
  }

  Future<void> getAllMessage({required int receiverId}) async {
    try {
      _messages = await _chatService.getAllMessage(receiverId: receiverId);
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> send(ChatMessage chatMessage) async {
    final connectionId = _connectionId;

    if (connectionId != null) {
      try {
        _messages.add(chatMessage);
        notifyListeners();
        await _chatService.pushMessage(
          chatMessage: chatMessage,
          connectionId: connectionId,
        );
      } on Failure {
        _messages.removeLast();
        notifyListeners();
        rethrow;
      }
    }
  }
}
