enum UserRole { OWNER, ADMIN, USER, GUEST }

extension RoleExtension on UserRole {
  String get value => toString().split('.').last;
}
