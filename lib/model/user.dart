import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String email;
  final List<String> groups;
  final String? photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.groups,
    required this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? groups,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      groups: groups ?? this.groups,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
