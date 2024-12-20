// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/model/setting.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String id;
  final String name;
  final String createdBy;
  // final Setting settings;
  @JsonKey(fromJson: _membersFromJson, toJson: _membersToJson)
  final List<Member> members;
  final String groupPhoto;

  Group({
    required this.id,
    required this.name,
    required this.createdBy,
    // required this.settings,
    required this.members,
    required this.groupPhoto,
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
    Setting? settings,
    String? groupPhoto,
    List<Member>? members,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      // settings: settings ?? this.settings,
      members: members ?? this.members,
      groupPhoto: groupPhoto ?? this.groupPhoto,
    );
  }
}
