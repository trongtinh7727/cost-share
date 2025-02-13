import 'dart:async';

import 'package:cost_share/model/budget.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/service/firebase_messaging_service.dart';
import 'package:cost_share/utils/enum/notification_status.dart';
import 'package:cost_share/utils/enum/notification_type.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:cost_share/utils/extension/string_ext.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/model/notification.dart' as AppNotification;

class BudgetBloc extends BaseBloC {
  final BudgetRepository _budgetRepository;
  final GroupRepository _groupRepository;
  final NotificationRepository _notificationRepository;
  final String groupId;
  final String userId;

  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService().instance;

  BudgetBloc(
    this._budgetRepository,
    this._groupRepository,
    this._notificationRepository,
    this.groupId,
    this.userId,
  );

  final _category = BehaviorSubject<AppCategory>();
  final _groupMembers = BehaviorSubject<List<UserSplit>>();
  Stream<AppCategory> get categoryStream => _category.stream;

  Stream<List<UserSplit>> get groupMembersStream => _groupMembers.stream;
  StreamSubscription<List<UserSplit>>? _groupMembersSubscription;

  AppCategory get category => _category.value;

  double _amount = 0;
  double _alertPoint = 0;
  bool _isEnableAlert = false;
  double get amount => _amount;
  double get alertPoint => _alertPoint;
  bool get isEnableAlert => _isEnableAlert;
  double get walletRemaining => _budgetRemaining[category.label] ?? 0;

  Map<String, double> _budgetRemaining = {};

  void setAmount(String amount) {
    _amount = amount.thousandsToDouble();
  }

  void setAlertPoint(double point) {
    _alertPoint = point;
  }

  void setIsEnableAlert(bool isEnableAlert) {
    _isEnableAlert = isEnableAlert;
  }

  void setCategory(AppCategory category) {
    _category.add(category);
  }

  void selectCategory(int index) {
    _category.add(AppCategoryExtension.fromIndex(index));
  }

  void getWalletRemaining(String groupId) {
    _budgetRepository.getGroupBudgets(groupId).then((budgets) {
      budgets.forEach((budget) {
        _budgetRemaining[budget.category] = budget.remainingAmount;
      });
    });
  }

  void getGroupMembers() {
    _groupMembersSubscription =
        _groupRepository.getGroupMembers(groupId).listen((members) {
      _groupMembers.add(members);
    }, onError: (error) {
      print("Error fetching group members: $error");
    });
  }

  void addBudget(int month, int year) async {
    try {
      // Map group members to contributions
      Map<String, double> contributions = {
        for (var member in _groupMembers.value) member.userId!: 0.0,
      };

      // Create a Budget object
      Budget budget = Budget(
        id: groupId + category.name + '$month$year',
        category: category.name,
        totalAmount: _amount,
        remainingAmount: _amount,
        contributions: contributions,
        groupId: groupId,
        isEnableAlert: _isEnableAlert,
        alertPoint: _alertPoint,
      );

      // Save the budget using the repository
      await _budgetRepository.addOrUpdateBudget(budget);

      // Optional: Log or handle success feedback
      print("Budget added successfully.");
    } catch (error) {
      // Handle any errors during the budget creation process
      print("Error adding budget: $error");
    }
  }

  void addContribution(Budget budget, String userId) async {
    try {
      // Update the contribution amount
      budget.contributions[userId] = _amount;
      // Update the budget using the repository
      await _budgetRepository.addOrUpdateBudget(budget);
      // Optional: Log or handle success feedback
      print("Contribution added successfully.");
    } catch (error) {
      // Handle any errors during the contribution process
      print("Error adding contribution: $error");
    }
  }

  Future<void> remindFunds(Budget budget, String title, String body) async {
    try {
      // Get the group members
      List<UserSplit> members = _groupMembers.value;
      // Get the group budget
      // Get the members who have not contributed
      double amountPerPerson = budget.totalAmount / budget.contributions.length;
      List<UserSplit> nonContributors = members
          .where((member) =>
              (budget.contributions[member.userId!] ?? double.infinity) <
              amountPerPerson)
          .toList();
      // Send a reminder to each non-contributor
      for (var member in nonContributors) {
        if (member.FCMToken != null) {
          // Send a reminder to the user
          _firebaseMessagingService.sendFCMMessage(
            title: title,
            body: body,
            FCMToken: member.FCMToken!,
          );

          // Save the reminder using the repository
          _notificationRepository.addNotification(AppNotification.Notification(
            groupId: groupId,
            userId: member.userId!,
            message: NotificationType.CONTRIBUTE_BUDGET.name,
            status: NotificationStatus.UNREAD.name,
            timestamp: DateTime.now(),
            id: '',
            data: {
              'name': budget.category,
              'amount': amountPerPerson.toCommaSeparated(),
            },
          ));
        }
      }
      // Optional: Log or handle success feedback
      print("Reminders sent successfully.");
    } catch (error) {
      // Handle any errors during the reminder process
      print("Error sending reminders: $error");
    }
  }

  @override
  void dispose() {
    _groupMembersSubscription?.cancel(); // Ensure the subscription is canceled
    _category.close();
    _groupMembers.close();
  }

  @override
  void init() {
    _category.add(AppCategory.SHOPPING);
    getWalletRemaining(groupId);
    getGroupMembers();
  }
}
