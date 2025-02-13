import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/notification.dart';

abstract class NotificationRepository {
  Future<void> addNotification(Notification notification);
  Future<void> deleteNotification(String notificationId);
  Stream<List<Notification>> getNotificationsStream(String userId);
  Stream<List<Notification>> getNotificationsOfUserOrGroupStream(
      String userId, String groupId);
  Future<void> updateNotification(Notification notification);
}

class NotificationRepositoryImpl extends NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addNotification(Notification notification) {
    try {
      return _firestore.collection('notifications').add(notification.toJson());
    } catch (e) {
      throw Exception('Failed to add notification: $e');
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) {
    try {
      return _firestore
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  @override
  Stream<List<Notification>> getNotificationsStream(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Notification.fromJson(data).copyWith(id: doc.id);
            }).toList());
  }

  @override
  Future<void> updateNotification(Notification notification) {
    try {
      return _firestore
          .collection('notifications')
          .doc(notification.id)
          .update(notification.toJson());
    } catch (e) {
      throw Exception('Failed to update notification: $e');
    }
  }

  @override
  Stream<List<Notification>> getNotificationsOfUserOrGroupStream(
      String userId, String groupId) {
    return _firestore
        .collection('notifications')
        .where('groupId', isEqualTo: groupId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              return data['userId'] == userId || data['userId'] == '';
            }).map((doc) {
              final data = doc.data();
              return Notification.fromJson(data).copyWith(id: doc.id);
            }).toList());
  }
}
