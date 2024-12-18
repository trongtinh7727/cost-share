import 'package:cost_share/model/budget.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/model/setting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String id;
  final String name;
  final String createdBy;
  final Setting settings;
  final List<Member> members;
  final List<Budget> budgets;
  final List<Expense> expenses;

  Group({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.settings,
    required this.members,
    required this.budgets,
    required this.expenses,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
