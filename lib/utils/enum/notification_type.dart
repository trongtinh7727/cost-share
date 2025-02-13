enum NotificationType {
  NEW_EXPENSE_ADDED,
  UPDATE_EXPENSE,
  DELETE_EXPENSE,
  NEW_MEMBER_ADDED,
  REMOVE_MEMBER,
  NEW_BUDGET,
  UPDATE_BUDGET,
  DELETE_BUDGET,
  DEBT_PAID,
  DEBT_UNPAID
}

extension NotificationTypeExtension on NotificationType {
  String get name {
    switch (this) {
      case NotificationType.NEW_EXPENSE_ADDED:
        return 'NEW_EXPENSE_ADDED';
      case NotificationType.UPDATE_EXPENSE:
        return 'UPDATE_EXPENSE';
      case NotificationType.DELETE_EXPENSE:
        return 'DELETE_EXPENSE';
      case NotificationType.NEW_MEMBER_ADDED:
        return 'NEW_MEMBER_ADDED';
      case NotificationType.REMOVE_MEMBER:
        return 'REMOVE_MEMBER';
      case NotificationType.NEW_BUDGET:
        return 'NEW_BUDGET';
      case NotificationType.UPDATE_BUDGET:
        return 'UPDATE_BUDGET';
      case NotificationType.DELETE_BUDGET:
        return 'DELETE_BUDGET';
      case NotificationType.DEBT_PAID:
        return 'DEBT_PAID';
      case NotificationType.DEBT_UNPAID:
        return 'DEBT_UNPAID';
      default:
        return '';
    }
  }

  static NotificationType fromString(String type) {
    switch (type) {
      case 'NEW_EXPENSE_ADDED':
        return NotificationType.NEW_EXPENSE_ADDED;
      case 'UPDATE_EXPENSE':
        return NotificationType.UPDATE_EXPENSE;
      case 'DELETE_EXPENSE':
        return NotificationType.DELETE_EXPENSE;
      case 'NEW_MEMBER_ADDED':
        return NotificationType.NEW_MEMBER_ADDED;
      case 'REMOVE_MEMBER':
        return NotificationType.REMOVE_MEMBER;
      case 'NEW_BUDGET':
        return NotificationType.NEW_BUDGET;
      case 'UPDATE_BUDGET':
        return NotificationType.UPDATE_BUDGET;
      case 'DELETE_BUDGET':
        return NotificationType.DELETE_BUDGET;
      case 'DEBT_PAID':
        return NotificationType.DEBT_PAID;
      case 'DEBT_UNPAID':
        return NotificationType.DEBT_UNPAID;
      default:
        return NotificationType.NEW_EXPENSE_ADDED;
    }
  }
}