import 'dart:async';
import 'dart:developer';

import 'package:bounce_patient_app/src/config/app_config.dart';
import 'package:bounce_patient_app/src/modules/chat/models/chat_message.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:signalr_netcore/signalr_client.dart';

const _errorMessage = 'Failed to connect to the server';

class SignalRWebsocketService implements IChatWebsocketService {
  HubConnection? _hubConnection;
  bool connectionIsOpen = false;
  final _messageController = StreamController<ChatMessage>();
  final serverURL = '${APIURLs.domain}/chat';

  @override
  Future<void> openConnection() async {
    try {
      await _openChatConnection();
    } on Failure {
      rethrow;
    }
  }

  Future<void> _openChatConnection() async {
    try {
      if (_hubConnection == null) {
        final httpConnectionOptions = HttpConnectionOptions(
          logMessageContent: true,
        );

        _hubConnection = HubConnectionBuilder()
            .withUrl(serverURL, options: httpConnectionOptions)
            .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000]).build();
        _hubConnection!.onclose(({error}) => connectionIsOpen = false);
        _hubConnection!.onreconnecting(({error}) {
          connectionIsOpen = false;
        });
        _hubConnection!.onreconnected(({connectionId}) {
          connectionIsOpen = true;
        });
        _hubConnection!.on("OnMessage", (data) async {
          final user = AppSession.user;

          if (user != null) {
            final dataList = data;

            if (dataList != null) {
              final chatMessage =
                  ChatMessage.fromJson(dataList.first as Map<String, dynamic>);

              if (chatMessage.receiverId == user.id) {
                _messageController.sink.add(chatMessage);
              }
            }
          }
        });
      }

      await _startConnection();
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  Future<void> _startConnection() async {
    if (_hubConnection!.state != HubConnectionState.Connected) {
      try {
        await _hubConnection!.start();
        connectionIsOpen = true;
        log('Websocket connection state ===========> ${_hubConnection!.state}');
      } on Exception catch (e) {
        log(e.toString());
        throw Failure(_errorMessage);
      } on Error {
        throw Failure(_errorMessage);
      }
    }
  }

  @override
  Future<void> sendMessage(ChatMessage chatMessage) async {
    try {
      _openChatConnection();
      _hubConnection!.invoke("Send", args: <Object>[]);
    } on Exception {
      throw Failure(_errorMessage);
    } on Error {
      throw Failure(_errorMessage);
    }
  }

  @override
  String? getConnectionId() {
    final hubconeection = _hubConnection;
    if (hubconeection == null) {
      return null;
    }

    return hubconeection.connectionId;
  }

  @override
  Stream<ChatMessage> getIncomingMessage() async* {
    try {
      yield* _messageController.stream.asBroadcastStream();
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }

  @override
  Future<void> closeConnection() async {
    try {
      if (_hubConnection != null) {
        await _hubConnection!.stop();
      }
      await _messageController.close();
    } on Error {
      throw InternalFailure();
    } on Exception {
      throw InternalFailure();
    }
  }
}
