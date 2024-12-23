import 'package:json_annotation/json_annotation.dart';

part 'budget.g.dart';

@JsonSerializable()
class Budget {
  final String? id;
  final String groupId;
  final String category;
  final double totalAmount;
  final double remainingAmount;
  final Map<String, double> contributions;
  final bool isEnableAlert;
  final double alertPoint;

  Budget({
    this.id,
    required this.category,
    required this.totalAmount,
    required this.remainingAmount,
    required this.contributions,
    required this.groupId,
    this.isEnableAlert = false,
    this.alertPoint = 0.0,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  Budget copyWith({
    String? id,
    String? category,
    double? totalAmount,
    double? remainingAmount,
    Map<String, double>? contributions,
    String? groupId,
    bool? isEnableAlert,
    double? alertPoint,
  }) {
    return Budget(
      id: id ?? this.id,
      category: category ?? this.category,
      totalAmount: totalAmount ?? this.totalAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      contributions: contributions ?? this.contributions,
      groupId: groupId ?? this.groupId,
      isEnableAlert: isEnableAlert ?? this.isEnableAlert,
      alertPoint: alertPoint ?? this.alertPoint,
    );
  }
}
