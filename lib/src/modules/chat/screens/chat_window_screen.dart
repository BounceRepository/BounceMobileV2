import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

class ChatWindowScreen extends StatelessWidget {
  const ChatWindowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'Dr Bellamy',
        actions: [
          AppBarSvgIcon(
            AppIcons.call,
            onTap: () {},
          ),
          AppBarSvgIcon(
            AppIcons.video,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
