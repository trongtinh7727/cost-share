import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/notification_status.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/date_ext.dart';
import 'package:cost_share/utils/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:cost_share/model/notification.dart' as model;
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.notification,
      required this.onRead,
      required this.onDelete});
  final model.Notification notification;
  final Future<void> Function(model.Notification notification) onRead;
  final Future<void> Function(String notificationId) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: notification.status == NotificationStatus.UNREAD.name
            ? AppColors.colorViolet20
            : AppColors.colorLight80,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: notification.status == NotificationStatus.UNREAD.name? 1 : 0.5,
          openThreshold: 0.2,
          closeThreshold: 0.2,
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(notification.id);
              },
              icon: Icons.delete,
              backgroundColor: AppColors.colorRed100,
              label: context.localization.delete,
            ),
            if (notification.status == NotificationStatus.UNREAD.name)
              SlidableAction(
                onPressed: (context) {
                  onRead(notification);
                },
                icon: Icons.bookmark,
                backgroundColor: AppColors.colorGreen100,
                label: context.localization.markAsRead,
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message.toNotificationTitle(context.localization),
                style: AppTextStyles.body2
                    .copyWith(color: AppColors.colorDark100)),
            Text(
                notification.message.toNotificationBody(
                    context.localization, notification.data),
                style:
                    AppTextStyles.body1.copyWith(color: AppColors.colorDark50)),
            Text(
              notification.timestamp
                  .toCustomTimeFormat(format: 'dd MMM, yyyy hh:mm a'),
              style: AppTextStyles.body3.copyWith(color: AppColors.colorDark50),
            ),
          ],
        ),
      ),
    );
  }
}
