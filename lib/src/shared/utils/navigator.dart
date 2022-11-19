import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static Future<dynamic> to(BuildContext context, Widget nextScreen) async {
   return await Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen));
  }

  static void removeAllUntil(BuildContext context, Widget nextScreen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => nextScreen),
      (Route<dynamic> route) => false,
    );
  }
}
