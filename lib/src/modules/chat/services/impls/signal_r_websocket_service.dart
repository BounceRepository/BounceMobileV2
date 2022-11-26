import 'dart:async';
import 'dart:developer';

import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:signalr_netcore/signalr_client.dart';

const _serverURL = 'http://bouneproj-001-site1.btempurl.com/chat';

class SignalRWebsocketService implements IChatWebsocketService {
  HubConnection? _hubConnection;
  bool connectionIsOpen = false;

  @override
  Future<ChatMessage?> openConnection() async {
    try {
      return await _openChatConnection();
    } on Failure {
      rethrow;
    }
  }

  Future<ChatMessage?> _openChatConnection() async {
    try {
      if (_hubConnection == null) {
        final httpConnectionOptions = HttpConnectionOptions(
          logMessageContent: true,
        );

        _hubConnection = HubConnectionBuilder()
            .withUrl(_serverURL, options: httpConnectionOptions)
            .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000]).build();
        _hubConnection!.onclose(({error}) => connectionIsOpen = false);
        _hubConnection!.onreconnecting(({error}) {
          connectionIsOpen = false;
        });
        _hubConnection!.onreconnected(({connectionId}) {
          connectionIsOpen = true;
        });
        _hubConnection!.on("OnMessage", (data) async {
          try {
            await _handleIncommingChatMessage(data);
          } on Failure {
            rethrow;
          }
        });
      }

      if (_hubConnection!.state != HubConnectionState.Connected) {
        await _hubConnection!.start();
        connectionIsOpen = true;
        log('Websocket connection state ===========> ${_hubConnection!.state}');
      }
    } catch (e) {
      throw Failure('Failed to connect to the server');
    }
    return null;
  }

  Future<ChatMessage> _handleIncommingChatMessage(List<Object?>? args) async {
    log('New message');
    try {
      final newMessage = ChatMessage(
        id: Utils.getGuid(),
        text: args![0] as String,
        receiverId: args[1] as int,
        type: MessageType.text,
        createdAt: DateTime.parse(args[3] as String),
      );
      return newMessage;
    } catch (e) {
      log(e.toString());
      throw Failure('Failed to process incoming message');
    }
  }

  @override
  Future<void> sendMessage(ChatMessage chatMessage) async {
    try {
      _openChatConnection();
      _hubConnection!.invoke("Send", args: <Object>[]);
    } catch (e) {
      log(e.toString());
      throw Failure('Failed to send message');
    }
  }
}
