// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'package:cost_share/model/group.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/user_role.dart';

class GroupBloc extends BaseBloC {
  final GroupRepository _groupRepository;
  final String? groupId;

  GroupBloc(this._groupRepository, {this.groupId});

  String _groupName = '';
  final _groupMembers = BehaviorSubject<List<UserSplit>>();
  String _email = '';
  final _errorSubject = BehaviorSubject<String>();

  String get groupName => _groupName;
  String get email => _email;
  Stream<List<UserSplit>> get groupMembersStream => _groupMembers.stream;
  StreamSubscription<List<UserSplit>>? _groupMembersSubscription;
  Stream<String> get errorStream => _errorSubject.stream;

  void onChangeGroupName(String groupName) {
    _groupName = groupName;
  }

  void onChangeEmail(String email) {
    _email = email;
  }

  void clearError() {
    _errorSubject.add('');
  }

  void createGroup(String userId) {
    Group group = Group(
      id: '',
      name: _groupName,
      createdBy: userId,
      totalBudget: 0,
      totalExpense: 0,
      members: [Member(userId: userId, role: UserRole.OWNER.value)],
      groupPhoto:
          'https://cdn3.vectorstock.com/i/1000x1000/24/27/people-group-avatar-character-vector-12392427.jpg',
    );
    _groupRepository.createGroup(group);
  }

  void getGroupMembers() {
    _groupMembersSubscription =
        _groupRepository.getGroupMembers(groupId!).listen((members) {
      _groupMembers.add(members);
    }, onError: (error) {
      print("Error fetching group members: $error");
    });
  }

  @override
  void dispose() {
    _groupMembersSubscription?.cancel();
    _groupMembers.close();
    _errorSubject.close();
  }

  @override
  void init() {
    if (groupId != null) {
      getGroupMembers();
    }
  }

  void removeMember(String? userId) {
    _groupRepository.removeMember(groupId!, userId);
  }

  void addMember(BuildContext context) async {
    try {
      await _groupRepository.addMember(groupId!, _email, context);
      context.pop();
    } catch (e) {
      _errorSubject.add('${e.toString().replaceAll('Exception: ', '')}');
    }
  }

  Future<List<UserSplit>> getTotalDebt(String groupId, String userId) async {
    try {
      List<UserSplit> members = [];

      for (var element in _groupMembers.value) {
        if (element.userId == userId) continue;
        double totalDebt = await _groupRepository.getTotalDebt(
            groupId, userId, element.userId);
        double totalCredit = await _groupRepository.getTotalDebt(
            groupId, element.userId!, userId);
        element.amount = totalDebt - totalCredit;

        members.add(element);
      }

      return members;
    } catch (e) {
      _errorSubject.add('Error calculating member debts: $e');
      return [];
    }
  }

  Future<void> markAsPaid(
      String groupId, String currentUserId, String userId) async {
    await _groupRepository.markAsPaid(groupId, currentUserId, userId);
    await _groupRepository.markAsPaid(groupId, userId, currentUserId);
  }
}
