import 'package:json_annotation/json_annotation.dart';

 part 'split.g.dart';

@JsonSerializable()
class Split {
  final String userId;
  final String  expenseId;
  final double ratio;
  final double amount;
  final bool isPaid;

  Split({
    required this.userId,
    required this.expenseId,
    required this.ratio,
    required this.amount,
    required this.isPaid,
  });

  factory Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);
  Map<String, dynamic> toJson() => _$SplitToJson(this);
}
