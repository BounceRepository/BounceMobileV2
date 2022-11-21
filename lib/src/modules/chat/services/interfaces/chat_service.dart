import 'package:bounce_patient_app/src/modules/chat/models/message.dart';

abstract class IChatService {
  Future<List<Message>> getAllMessage();
}
