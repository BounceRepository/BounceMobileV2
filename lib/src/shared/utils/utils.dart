import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:uuid/uuid.dart';

final random = Random();

class Utils {
  Utils._();

  static String getGuid() {
    const uuid = Uuid();
    return uuid.v4();
  }

  static String convertFileToBytes(File image) {
    final bytes = File(image.path).readAsBytesSync();
    return base64Encode(bytes);
  }

  static int? getFeedGroupId(String feedGroup) {
    if (feedGroup.toLowerCase() == 'relationship') {
      return 1;
    } else if (feedGroup.toLowerCase() == 'self care') {
      return 2;
    }
    if (feedGroup.toLowerCase() == 'work ethics') {
      return 3;
    }
    if (feedGroup.toLowerCase() == 'family') {
      return 4;
    }
    if (feedGroup.toLowerCase() == 'sexuality') {
      return 6;
    }
    if (feedGroup.toLowerCase() == 'parenting') {
      return 7;
    }

    return null;
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    }
    if (hour < 17) {
      return 'Good Afternoon,';
    }
    return 'Good Evening,';
  }

  static String getNumberFromFormattedAmount(String str) {
    if (str.length == 1) {
      return str;
    }
    return str.substring(1).replaceAll(',', '');
  }
}
