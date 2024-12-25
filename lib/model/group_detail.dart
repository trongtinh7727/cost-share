import 'package:json_annotation/json_annotation.dart';

part 'group_detail.g.dart';

@JsonSerializable()
class GroupDetail {
  final String groupId;
  final String groupName;
  final String groupPhoto;
  final int memberCount;
  final String authorName;
  final String authorPhoto;
  final double totalExpense;
  final double totalBudget;

  GroupDetail({
    required this.groupId,
    required this.groupName,
    required this.groupPhoto,
    required this.memberCount,
    required this.authorName,
    required this.authorPhoto,
    required this.totalExpense,
    required this.totalBudget,
    
  });

  factory GroupDetail.fromJson(Map<String, dynamic> json) => _$GroupDetailFromJson(json);
  Map<String, dynamic> toJson() => _$GroupDetailToJson(this);
}
