import 'package:bounce_patient_app/src/config/app_config.dart';

class ChatApiUrls {
  ChatApiUrls._();

  static String getAllChatMessage = '${APIURLs.baseURL}/Notification/GetAllChatMessages';
  static String pushMessage = '${APIURLs.baseURL}/Notification/PushMessage';
}
