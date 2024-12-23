import 'package:json_annotation/json_annotation.dart';
import 'member.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String id;
  final String name;
  final String createdBy;
  @JsonKey(fromJson: _membersFromJson, toJson: _membersToJson)
  final List<Member> members;
  final String groupPhoto;
  final double totalExpense;
  final double totalBudget;

  Group({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.members,
    required this.groupPhoto,
    required this.totalExpense,
    required this.totalBudget,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  static List<Member> _membersFromJson(List<dynamic> json) =>
      json.map((e) => Member.fromJson(e as Map<String, dynamic>)).toList();

  static List<Map<String, dynamic>> _membersToJson(List<Member> members) =>
      members.map((e) => e.toJson()).toList();

  Group copyWith({
    String? id,
    String? name,
    String? createdBy,
    List<Member>? members,
    String? groupPhoto,
    double? totalExpense,
    double? totalBudget,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
      groupPhoto: groupPhoto ?? this.groupPhoto,
      totalExpense: totalExpense ?? this.totalExpense,
      totalBudget: totalBudget ?? this.totalBudget,
    );
  }
}