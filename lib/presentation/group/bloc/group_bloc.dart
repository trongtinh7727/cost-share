import 'package:cost_share/model/group.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/user_role.dart';

class GroupBloc extends BaseBloC {
  final GroupRepository _groupRepository;

  GroupBloc(this._groupRepository);

  String _groupName = '';

  String get groupName => _groupName;

  void onChangeGroupName(String groupName) {
    _groupName = groupName;
  }

  void createGroup(String userId) {
    Group group = Group(
      id: '',
      name: _groupName,
      createdBy: userId,
      members: [Member(userId: userId, role: UserRole.OWNER.value)],
      groupPhoto:
          'https://cdn3.vectorstock.com/i/1000x1000/24/27/people-group-avatar-character-vector-12392427.jpg',
    );
    _groupRepository.createGroup(group);
  }

  @override
  void dispose() {}

  @override
  void init() {}
}
