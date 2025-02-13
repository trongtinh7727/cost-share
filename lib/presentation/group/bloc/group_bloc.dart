// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/service/firebase_messaging_service.dart';
import 'package:cost_share/utils/enum/notification_status.dart';
import 'package:cost_share/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cost_share/model/notification.dart' as AppNotification;

import 'package:cost_share/model/group.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/user_role.dart';

class GroupBloc extends BaseBloC {
  final GroupRepository _groupRepository;
  final String? groupId;
  final NotificationRepository _notificationRepository;
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService().instance;

  GroupBloc(
    this._groupRepository,
    this._notificationRepository, {
    this.groupId,
  });

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
    String userName = _groupMembers.value
        .firstWhere((element) => element.userId == userId)
        .userName!;
    _notificationRepository.addNotification(AppNotification.Notification(
      groupId: groupId!,
      userId: '',
      message: NotificationType.REMOVE_MEMBER.name,
      status: NotificationStatus.UNREAD.name,
      timestamp: DateTime.now(),
      id: '',
      data: {
        'name': userName,
      },
    ));
  }

  void addMember(BuildContext context) async {
    try {
      await _groupRepository.addMember(groupId!, _email, context);
      String userName = _groupMembers.value
          .firstWhere((element) => element.email == _email)
          .userName!;
      _notificationRepository.addNotification(AppNotification.Notification(
        groupId: groupId!,
        userId: '',
        message: NotificationType.REMOVE_MEMBER.name,
        status: NotificationStatus.UNREAD.name,
        timestamp: DateTime.now(),
        id: '',
        data: {
          'name': userName,
        },
      ));

      context.pop();
    } catch (e) {}
  }

  void updateGroupName(BuildContext context) async {
    try {
      await _groupRepository.updateGroupName(groupId!, _groupName);
      context.pop();
    } catch (e) {
      _errorSubject.add('${e.toString().replaceAll('Exception: ', '')}');
    }
  }

  Future<void> deleteGroup() async {
    try {
      await _groupRepository.deleteGroup(groupId!);
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
      {required String title,
      required String body,
      required String amout,
      required String groupId,
      required String currentUserId,
      required String userId}) async {
    await _groupRepository.markAsPaid(groupId, currentUserId, userId);
    await _groupRepository.markAsPaid(groupId, userId, currentUserId);

    // Send notification to all group members
    _groupMembers.value.forEach((userSplit) {
      if (userSplit.FCMToken != null &&
          (userSplit.userId == currentUserId || userSplit.userId == userId)) {
        // Send notification to the user
        _firebaseMessagingService.sendFCMMessage(
            title: title, body: body, FCMToken: userSplit.FCMToken!);

        _notificationRepository.addNotification(AppNotification.Notification(
          groupId: groupId,
          userId: userSplit.userId!,
          message: NotificationType.DEBT_PAID.name,
          status: NotificationStatus.UNREAD.name,
          timestamp: DateTime.now(),
          id: '',
          data: {
            'name': userSplit.userName!,
          },
        ));
      }
    });
  }
}
