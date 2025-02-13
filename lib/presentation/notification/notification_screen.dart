import 'package:cost_share/manager/notification_manager.dart';
import 'package:cost_share/presentation/notification/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationManager notificationManager;
  @override
  Widget build(BuildContext context) {
    notificationManager = context.read<NotificationManager>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
        ),
        body: StreamBuilder(
          stream: notificationManager.notificationsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No notifications available'));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                        notification: snapshot.data![index],
                        onRead: notificationManager.markNotificationAsRead,
                        onDelete: notificationManager.deleteNotification);
                  });
            }
          },
        ));
  }
}
