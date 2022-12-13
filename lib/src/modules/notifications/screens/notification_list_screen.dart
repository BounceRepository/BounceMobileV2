import 'dart:developer';

import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/widgets/notification_tile.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  bool isLoading = false;

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

    if (controller.notifications.isEmpty || controller.failure != null) {
      try {
        setState(() => isLoading = true);
        await controller.getAllNotification();
        setState(() => isLoading = false);
      } on Failure catch (e) {
        setState(() => isLoading = false);
        controller.setFailure(e);
      }
    }
  }

  void markAsRead() async {
    final controller = context.read<NotificationController>();
    controller.resetUnreadCount();
    try {
      await controller.readNotifications();
    } on Failure catch (e) {
      log(e.message);
    }
  }

  void onRefresh() async {
    final controller = context.read<NotificationController>();

    try {
      await controller.getAllNotification();
    } on Failure catch (e) {
      controller.setFailure(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: Colors.transparent,
        label: 'Notifications',
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<NotificationController>(
          builder: (context, controller, _) {
            if (isLoading) {
              return const Center(child: CustomLoadingIndicator());
            }

            final error = controller.failure;
            if (error != null) {
              return ErrorScreen(error: error, retry: getAllNotification);
            }

            if (controller.notifications.isEmpty) {
              return const EmptyListView();
            }

            final notifications = controller.notifications;
            return RefreshIndicator(
              onRefresh: () async => onRefresh(),
              child: ListView.builder(
                itemCount: notifications.length,
                padding: AppPadding.defaultPadding,
                physics:
                    const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return NotificationTile(notification);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
