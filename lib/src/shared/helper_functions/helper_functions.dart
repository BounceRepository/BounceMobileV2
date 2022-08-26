import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';

class HelperFunctions {
  HelperFunctions._();

  static String generateUniqueId() {
    const uuid = Uuid();
    return uuid.v4();
  }

  static String convertToBytes(File image) {
    final bytes = File(image.path).readAsBytesSync();
    return base64Encode(bytes);
  }
}
