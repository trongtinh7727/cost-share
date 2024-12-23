// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/split.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/utils/extension/string_ext.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/enum/app_wallet.dart';

class TransactionBloc extends BaseBloC {
  final BudgetRepository _budgetRepository;
  final GroupRepository _groupRepository;
  final ExpenseRepository _expenseRepository;
  final String groupId;
  final String userId;

  TransactionBloc(
    this._budgetRepository,
    this._groupRepository,
    this._expenseRepository,
    this.groupId,
    this.userId,
  );

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
  double get walletRemaining => _budgetRemaining[category.label] ?? 0;

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

  void addExpense() async {
    final expense = Expense(
      id: '',
      userId: userId,
      groupId: groupId,
      paidBy: wallet.name,
      amount: amount,
      description: description,
      category: category.name,
      date: DateTime.now(),
    );
    await _expenseRepository.addExpense(expense).then(
      (value) async {
        List<Split> splits = _groupMembers.value.map((userSplit) {
          return userSplit.toSplit(value.id, amount);
        }).toList();
        await _expenseRepository.addSplits(splits);
      },
    );
  }

  @override
  void dispose() {
    _groupMembersSubscription?.cancel(); // Ensure the subscription is canceled
    _category.close();
    _wallet.close();
    _groupMembers.close();
  }

  @override
  void init() {
    _category.add(AppCategory.SHOPPING);
    _wallet.add(AppWallet.PERSONAL);
    getWalletRemaining(groupId);
    getGroupMembers();
  }

  selectWallet(String wallet) {
    _wallet.add(AppWalletExtension.fromString(wallet));
  }
}
