import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String userId;
  final String message;
  final String status;
  final DateTime timestamp;

  Notification({
    required this.id,
    required this.userId,
    required this.message,
    required this.status,
    required this.timestamp,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}