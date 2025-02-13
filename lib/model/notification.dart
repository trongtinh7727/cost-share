import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String userId;
  final String groupId;
  final String message;
  final String status;
  final DateTime timestamp;
  final Map<String, String> data;

  Notification({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.message,
    required this.status,
    required this.timestamp,
    required this.data,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification copyWith({
    String? id,
    String? userId,
    String? groupId,
    String? message,
    String? status,
    DateTime? timestamp,
    Map<String, String>? data,
  }) {
    return Notification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      message: message ?? this.message,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      data: data ?? this.data,
    );
  }
}