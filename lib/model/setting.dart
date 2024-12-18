import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';


@JsonSerializable()
class Setting {
  final String currency;
  final String splitMethod;
  final bool allowFundContribution;

  Setting({
    required this.currency,
    required this.splitMethod,
    required this.allowFundContribution,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);
  Map<String, dynamic> toJson() => _$SettingToJson(this);
}