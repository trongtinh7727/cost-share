enum NotificationStatus {
  UNREAD,
  READ,
}

extension NotificationStatusExtension on NotificationStatus {
  String get name {
    switch (this) {
      case NotificationStatus.UNREAD:
        return 'unread';
      case NotificationStatus.READ:
        return 'read';

      default:
        return '';
    }
  }
}
