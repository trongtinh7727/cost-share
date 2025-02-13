import 'dart:async';

import 'package:cost_share/model/notification.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/notification_status.dart';
import 'package:rxdart/rxdart.dart';

class NotificationManager extends BaseBloC {
  final NotificationRepository _notificationRepository;

  NotificationManager(this._notificationRepository);

  final _notificationsSubject = BehaviorSubject<List<Notification>>();

  StreamSubscription<List<Notification>>? _notificationsSubscription;

  Stream<List<Notification>> get notificationsStream =>
      _notificationsSubject.stream;

  double get totalNotifications => _notificationsSubject.hasValue
      ? _notificationsSubject.value.length.toDouble()
      : 0;
  int get totalUnreadNotifications => _notificationsSubject.hasValue
      ? _notificationsSubject.value
          .where((notification) =>
              notification.status == NotificationStatus.UNREAD.name)
          .length
      : 0;

  Future<void> loadNotifications(String userId, String groupId) async {
    _notificationsSubscription?.cancel();
    _notificationsSubscription = _notificationRepository
        .getNotificationsOfUserOrGroupStream(userId, groupId)
        .listen((notifications) {
      _notificationsSubject.add(notifications);
    });
  }

  Future<void> markNotificationAsRead(Notification notification) async {
    await _notificationRepository.updateNotification(
      notification.copyWith(
        status: NotificationStatus.READ.name,
      ),
    );
  }

  Future<void> deleteNotification(String notificationId) async {
    await _notificationRepository.deleteNotification(notificationId);
  }

  @override
  void dispose() {
    _notificationsSubject.close();
    _notificationsSubscription?.cancel();
  }

  @override
  void init() {}
}
