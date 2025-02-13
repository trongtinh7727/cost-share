// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/service/firebase_messaging_service.dart';
import 'package:cost_share/utils/enum/notification_status.dart';
import 'package:cost_share/utils/enum/notification_type.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:rxdart/rxdart.dart';

import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/split.dart' as AppSplit;
import 'package:cost_share/model/notification.dart' as AppNotification;
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/enum/app_wallet.dart';
import 'package:cost_share/utils/extension/string_ext.dart';

class TransactionBloc extends BaseBloC {
  final BudgetRepository _budgetRepository;
  final GroupRepository _groupRepository;
  final ExpenseRepository _expenseRepository;
  final NotificationRepository _notificationRepository;
  final String groupId;
  final String userId;
  final String? expenseId;
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService().instance;

  TransactionBloc(
      this._budgetRepository,
      this._groupRepository,
      this._expenseRepository,
      this._notificationRepository,
      this.groupId,
      this.userId,
      {this.expenseId});

  final _category = BehaviorSubject<AppCategory>();
  final _wallet = BehaviorSubject<AppWallet>();
  final _groupMembers = BehaviorSubject<List<UserSplit>>();
  Stream<AppCategory> get categoryStream => _category.stream;
  Stream<AppWallet> get walletStream => _wallet.stream;
  Stream<List<UserSplit>> get groupMembersStream => _groupMembers.stream;
  StreamSubscription<List<UserSplit>>? _groupMembersSubscription;

  AppCategory get category => _category.value;
  AppWallet get wallet => _wallet.value;

  double _amount = 0;
  String _description = '';
  double get amount => _amount;
  String get description => _description;
  double get walletRemaining => _budgetRemaining[category.name] ?? 0;

  Map<String, double> _budgetRemaining = {};

  void setAmount(String amount) {
    _amount = amount.thousandsToDouble();
  }

  void setDescription(String description) {
    _description = description;
  }

  void setCategory(AppCategory category) {
    _category.add(category);
  }

  void selectCategory(int index) {
    _category.add(AppCategoryExtension.fromIndex(index));
    _wallet.add(AppWallet.PERSONAL);
  }

  void selectCategoryByName(String name) {
    _category.add(AppCategoryExtension.fromString(name));
  }

  void getWalletRemaining(String groupId, String month, String year) {
    _budgetRemaining = {};
    _budgetRepository.loadMonthlyBudget(groupId, month, year).listen((budgets) {
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

  Future<Expense> addExpense(
      DateTime date, String name, String title, String body) async {
    final expense = Expense(
      id: '',
      userId: userId,
      groupId: groupId,
      paidBy: wallet.name,
      amount: amount,
      description: description,
      category: category.name,
      date: date,
    );
    final addedExpense = await _expenseRepository.addExpense(expense);
    List<AppSplit.Split> splits = _groupMembers.value.map((userSplit) {
      return userSplit.toSplit(addedExpense.id, amount);
    }).toList();
    await _expenseRepository.addSplits(splits);

    // Send notification to all group members
    _groupMembers.value.forEach((userSplit) {
      if (userSplit.FCMToken != null) {
        // Send notification to the user
        _firebaseMessagingService.sendFCMMessage(
            title: title, body: body, FCMToken: userSplit.FCMToken!);
      }
    });

    _notificationRepository.addNotification(AppNotification.Notification(
      groupId: groupId,
      userId: '',
      message: NotificationType.NEW_EXPENSE_ADDED.name,
      status: NotificationStatus.UNREAD.name,
      timestamp: DateTime.now(),
      id: '',
      data: {
        'name': name,
        'amount': amount.toCommaSeparated(),
      },
    ));

    return addedExpense;
  }

  Future<List<AppSplit.Split>> getSplits(String expenseId) async {
    return _expenseRepository.getExpenseSplits(expenseId);
  }

  Future<List<UserSplit>> getUserSplits(String expenseId) async {
    return _expenseRepository.getExpenseUserSplits(expenseId);
  }

  @override
  void dispose() {
    _groupMembersSubscription?.cancel(); // Ensure the subscription is canceled
    _category.close();
    _wallet.close();
    _groupMembers.close();
  }

  @override
  void init() async {
    _category.add(AppCategory.SHOPPING);
    _wallet.add(AppWallet.PERSONAL);

    final now = DateTime.now();
    String month = now.month.toString();
    String year = now.year.toString();
    getWalletRemaining(groupId, month, year);
    getGroupMembers();
  }

  selectWallet(String wallet) {
    _wallet.add(AppWalletExtension.fromString(wallet));
  }

  void updateSplit(AppSplit.Split splitData) {
    _expenseRepository.updateSplit(splitData);
  }

  void removeExpense(String id) {
    _expenseRepository.deleteExpense(id);
  }
}
