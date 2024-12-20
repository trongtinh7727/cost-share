import 'package:cost_share/model/group.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class GroupManager {
  final GroupRepository groupRepository;
  final BehaviorSubject<Group?> _groupStream = BehaviorSubject<Group?>();

  GroupManager(this.groupRepository);

  Stream<Group?> get currentGroup => _groupStream.stream;

  Future<void> loadGroup(String groupId) async {
    try {
      _groupStream.addStream(groupRepository.getGroupById(groupId));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }
}
