import 'dart:math';

import 'package:cost_share/model/group.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/user_role.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BaseBloC {
  final GroupRepository _groupRepository;
  final String userId;
  MainBloc(this._groupRepository, this.userId);

  final _userGroupsSubject = BehaviorSubject<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get userGroupsStream =>
      _userGroupsSubject.stream;

  void loadUserGroups(String userId) async {
    // Load user groups from the repository
    try {
      _userGroupsSubject.addStream(_groupRepository.getUserGroups(userId));
    } catch (e) {
      print('Error loading user groups: $e');
    }
  }

  void createGroup() {
    Group group = Group(
      id: '',
      name: 'Group ${Random.secure().nextInt(100)}',
      createdBy: userId,
      members: [Member(userId: userId, role: UserRole.OWNER.value)],
      groupPhoto: 'https://cdn3.vectorstock.com/i/1000x1000/24/27/people-group-avatar-character-vector-12392427.jpg',
    );
    _groupRepository.createGroup(group);
    debugPrint('Group created');
  }

  @override
  void dispose() {
    _userGroupsSubject.close();
  }

  @override
  void init() {
    loadUserGroups(userId);
  }
}
