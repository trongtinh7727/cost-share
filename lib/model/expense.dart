import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final String id;
  final String userId;
  final String groupId;
  final String paidBy;
  final String category;
  final double amount;
  final String description;
  final DateTime date;
  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  final String? avatarUrl;
  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  final String? name;

  Expense({
    required this.category,
    required this.userId,
    required this.groupId,
    required this.id,
    required this.paidBy,
    required this.amount,
    required this.description,
    required this.date,
    this.avatarUrl,
    this.name,
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
    String? category,
    DateTime? date,
    String? avatarUrl,
    String? name,
  }) {
    return Expense(
      category: category ?? this.category,
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      id: id ?? this.id,
      paidBy: paidBy ?? this.paidBy,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      name: name ?? this.name,
    );
  }
}