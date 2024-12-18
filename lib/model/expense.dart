import 'package:cost_share/model/split.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final String id;
  final String paidBy;
  final double amount;
  final String description;
  final DateTime date;
  final List<Split> split;

  Expense({
    required this.id,
    required this.paidBy,
    required this.amount,
    required this.description,
    required this.date,
    required this.split,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}

