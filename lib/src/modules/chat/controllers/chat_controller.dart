import 'dart:developer';

import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/shared/controllers/base_controller.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';

class ChatController extends BaseController {
  final IChatService _chatService;
  final IChatWebsocketService _chatWebsocketService;

  ChatController({
    required IChatService chatService,
    required IChatWebsocketService websocketService,
  })  : _chatService = chatService,
        _chatWebsocketService = websocketService;

  String? _connectionId;
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  Future<void> startConnection() async {
    reset();
    try {
      await _chatWebsocketService.openConnection();
      final id = _chatWebsocketService.getConnectionId();
      if (id != null) {
        _connectionId = id;
        _isConnected = true;
        await _listenForIncomingMessage();
      }
    } on Failure {
      rethrow;
    }
  }

  Future<void> closeConnection() async {
    try {
      await _chatWebsocketService.closeConnection();
      _isConnected = false;
      _connectionId = null;
      _messages.clear();
    } on Failure {
      rethrow;
    }
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
      _messages.clear();
      _messages = await _chatService.getAllMessage(receiverId: receiverId);
      notifyListeners();
    } on Failure {
      rethrow;
    }
  }

  Future<void> sendMessage(ChatMessage chatMessage) async {
    final connectionId = _connectionId;

    if (connectionId != null) {
      try {
        _messages.add(chatMessage);
        notifyListeners();
        await _chatService.sendMessage(
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

  void clear() {
    _connectionId = null;
    _messages.clear();
  }
}
