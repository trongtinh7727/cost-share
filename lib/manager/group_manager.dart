import 'package:cost_share/model/budget.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:cost_share/utils/enum/sort_by.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class GroupManager extends BaseBloC {
  final GroupRepository _groupRepository;
  final ExpenseRepository _expenseRepository;
  final BudgetRepository _budgetRepository;

  GroupManager(
      this._groupRepository, this._expenseRepository, this._budgetRepository);

  String currentGroupId = "";
  String currentUserId = "";
  GroupDetail? get currentGroup => _userGroupsSubject.value.firstWhereOrNul(
        (element) => element.groupId == currentGroupId,
      );

  SortBy? _selectedSortBy;
  List<String> _selectedCategories = [];

  SortBy? get selectedSortBy => _selectedSortBy;
  List<String> get selectedCategories => _selectedCategories;

  final _userGroupsSubject = BehaviorSubject<List<GroupDetail>>();
  final _groupExpensesSubject = BehaviorSubject<List<Expense>>();
  final _groupBudgetSubject = BehaviorSubject<List<Budget>>();
  final _filteredExpensesSubject = BehaviorSubject<List<Expense>>();

  StreamSubscription<List<Expense>>? _groupExpensesSubscription;
  StreamSubscription<List<GroupDetail>>? _userGroupsSubscription;
  StreamSubscription<List<Budget>>? _groupBudgetSubscription;

  Stream<List<Expense>> get groupExpensesStream =>
      _filteredExpensesSubject.stream;
  Stream<List<GroupDetail>> get userGroupsStream => _userGroupsSubject.stream;
  Stream<List<Budget>> get groupBudgetStream => _groupBudgetSubject.stream;

  /// Calculate the total expense of the current group
  double get totalExpense => _filteredExpensesSubject.hasValue
      ? _filteredExpensesSubject.value
          .fold(0, (sum, expense) => sum + expense.amount)
      : 0;

  /// Calculate the total budget of the current group
  double get totalBudget => _groupBudgetSubject.hasValue
      ? _groupBudgetSubject.value
          .fold(0, (sum, budget) => sum + budget.totalAmount)
      : 0;

  /// Calculate the total remaining budget of the current group
  double get totalBudgetRemaining => _groupBudgetSubject.hasValue
      ? _groupBudgetSubject.value
          .fold(0, (sum, budget) => sum + budget.remainingAmount)
      : 0;

  /// Load user groups
  Future<void> loadUserGroups(String userId) async {
    currentUserId = userId;
    try {
      _userGroupsSubscription?.cancel();
      final userGroupsStream = _groupRepository.getUserGroups(userId);
      _userGroupsSubscription = userGroupsStream.listen((groups) {
        _userGroupsSubject.add(groups);
      });
    } catch (e) {
      print('Error loading user groups: $e');
    }
  }

  /// Set current group and load its data
  void setCurrentGroup(String groupId) {
    currentGroupId = groupId;
    loadGroupExpenses(groupId);

    final now = DateTime.now();
    String month = now.month.toString();
    String year = now.year.toString();
    loadGroupBudget(groupId, month, year);
  }

  /// Load group expenses
  Future<void> loadGroupExpenses(String groupId) async {
    try {
      _groupExpensesSubscription?.cancel();
      final expensesStream = _expenseRepository.getExpensesStream(groupId);
      _groupExpensesSubscription = expensesStream.listen((expenses) {
        _groupExpensesSubject.add(expenses);
        _filteredExpensesSubject.add(expenses); // Initialize filtered expenses
      });
    } catch (e) {
      print('Error loading group expenses: $e');
    }
  }

  /// Load group budget
  Future<void> loadGroupBudget(
      String groupId, String month, String year) async {
    try {
      _groupBudgetSubscription?.cancel();
      final budgetStream =
          _budgetRepository.loadMonthlyBudget(groupId, month, year);
      _groupBudgetSubscription = budgetStream.listen((budgets) {
        _groupBudgetSubject.add(budgets);
      });
    } catch (e) {
      print('Error loading group budget: $e');
    }
  }

  /// Filter and sort expenses
  void filterAndSortExpenses({
    List<String>? categories,
    SortBy? sortBy,
  }) {
    _selectedCategories = categories ?? [];
    _selectedSortBy = sortBy;

    List<Expense> expenses = _groupExpensesSubject.value;

    // Filter by categories
    if (categories != null && categories.isNotEmpty) {
      expenses = expenses
          .where((expense) => categories.contains(expense.category))
          .toList();
    }

    // Sort expenses
    if (sortBy != null) {
      switch (sortBy) {
        case SortBy.HIGHEST:
          expenses.sort((a, b) => b.amount.compareTo(a.amount));
          break;
        case SortBy.LOWEST:
          expenses.sort((a, b) => a.amount.compareTo(b.amount));
          break;
        case SortBy.NEWEST:
          expenses.sort((a, b) => b.date.compareTo(a.date));
          break;
        case SortBy.OLDEST:
          expenses.sort((a, b) => a.date.compareTo(b.date));
          break;
      }
    }

    _filteredExpensesSubject.add(expenses);
  }

  void filterExpensesByDate(int month, int year) {
    List<Expense> expenses = _groupExpensesSubject.value;
    expenses = expenses
        .where((expense) =>
            expense.date.month == month && expense.date.year == year)
        .toList();
    _filteredExpensesSubject.add(expenses);
  }

  void clear() {
    currentGroupId = "";
    currentUserId = "";
  }

  @override
  void dispose() {
    _userGroupsSubject.close();
    _groupBudgetSubject.close();
    _groupExpensesSubject.close();
    _filteredExpensesSubject.close();
    _groupExpensesSubscription?.cancel();
    _groupBudgetSubscription?.cancel();
  }

  @override
  void init() {}
}

extension on List<GroupDetail> {
  firstWhereOrNul(bool Function(dynamic element) param0) {
    try {
      return this.firstWhere(param0);
    } catch (e) {
      return null;
    }
  }
}
