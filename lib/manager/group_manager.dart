import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:rxdart/rxdart.dart';

class GroupManager extends BaseBloC {
  final GroupRepository groupRepository;
  GroupManager(this.groupRepository);

  String currentGroupId = "";
  GroupDetail? get currentGroup => _userGroupsSubject.value
      .firstWhere((element) => element.groupId == currentGroupId);

  final _userGroupsSubject = BehaviorSubject<List<GroupDetail>>();
  Stream<List<GroupDetail>> get userGroupsStream => _userGroupsSubject.stream;

  Future<void> loadUserGroups(String userId) async {
    try {
      _userGroupsSubject.addStream(groupRepository.getUserGroups(userId));
    } catch (e) {
      print('Error loading user groups: $e');
    }
  }

  void setCurrentGroup(String groupId) {
    currentGroupId = groupId;
  }

  @override
  void dispose() {
    _userGroupsSubject.close();
  }

  @override
  void init() {}
}
