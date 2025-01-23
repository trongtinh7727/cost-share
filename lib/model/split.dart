// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'split.g.dart';

@JsonSerializable()
class Split {
  final String userId;
  final String expenseId;
  final double ratio;
  final double amount;
  final bool isPaid;
  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  final String? id;

  Split({
    required this.userId,
    required this.expenseId,
    required this.ratio,
    required this.amount,
    required this.isPaid,
    this.id,
  });

  factory Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);
  Map<String, dynamic> toJson() => _$SplitToJson(this);

  Split copyWith({
    String? userId,
    String? expenseId,
    double? ratio,
    double? amount,
    bool? isPaid,
    String? id,
  }) {
    return Split(
      userId: userId ?? this.userId,
      expenseId: expenseId ?? this.expenseId,
      ratio: ratio ?? this.ratio,
      amount: amount ?? this.amount,
      isPaid: isPaid ?? this.isPaid,
      id: id ?? this.id,
    );
  }
}
