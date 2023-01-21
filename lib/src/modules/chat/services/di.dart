import 'package:bounce_patient_app/src/config/di_container.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/services/fakes/fake_chat_service_impl.dart';
import 'package:bounce_patient_app/src/modules/chat/services/fakes/fake_chat_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/impls/chat_service_impl.dart';
import 'package:bounce_patient_app/src/modules/chat/services/impls/signal_r_websocket_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_service.dart';
import 'package:bounce_patient_app/src/modules/chat/services/interfaces/chat_websocket_service.dart';

void chatControllersInit({required bool useFake}) {
  if (useFake) {
    diContainer.registerFactory(() => ChatController(
          chatService: FakeChatServiceImpl(),
          websocketService: FakeChatWebsocketService(),
        ));
  } else {
    diContainer.registerFactory(() => ChatController(
          chatService: diContainer(),
          websocketService: diContainer(),
        ));
  }
}

void chatServicesInit() {
  diContainer
      .registerLazySingleton<IChatService>(() => ChatServiceImpl(api: diContainer()));
  diContainer
      .registerLazySingleton<IChatWebsocketService>(() => SignalRWebsocketService());
}
