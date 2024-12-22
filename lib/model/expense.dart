import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final String id;
  final String userId;
  final String groupId;
  final String paidBy;
  final double amount;
  final String description;
  final DateTime date;

  Expense({
    required this.userId,
    required this.groupId,
    required this.id,
    required this.paidBy,
    required this.amount,
    required this.description,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Expense copyWith({
    String? id,
    String? userId,
    String? groupId,
    String? paidBy,
    double? amount,
    String? description,
    DateTime? date,
  }) {
    return Expense(
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      id: id ?? this.id,
      paidBy: paidBy ?? this.paidBy,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
