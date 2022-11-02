import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllNotification();
      markAsRead();
    });
  }

  void getAllNotification() async {
    final controller = context.read<NotificationController>();

    if (controller.notifications.isEmpty) {
      try {
        await controller.getAllNotification();
      } on Failure catch (e) {
        Messenger.error(message: e.message);
      }
    }
  }

  void markAsRead() {
    context.read<NotificationController>().markAsRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        label: 'Notifications',
      ),
      body: SafeArea(
        child: Consumer<NotificationController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (controller.notifications.isEmpty) {}

            final notifications = controller.notifications;
            return ListView.builder(
              itemCount: notifications.length,
              padding: AppPadding.defaultPadding,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationTile(notification);
              },
            );
          },
        ),
      ),
    );
  }
}
