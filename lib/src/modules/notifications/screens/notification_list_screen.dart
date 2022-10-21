import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_bell.dart';
import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_tile.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        label: 'Notifications',
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          padding: AppPadding.defaultPadding,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const NotificationTile();
          },
        ),
      ),
    );
  }
}
