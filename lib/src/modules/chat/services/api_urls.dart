import 'package:bounce_patient_app/src/config/app_config.dart';

class ChatApiUrls {
  ChatApiUrls._();

  static const getAllChatMessage = APIURLs.baseURL + '/Notification/GetAllChatMessages';
  static const pushMessage = APIURLs.baseURL + '/Notification/PushMessage';
}
