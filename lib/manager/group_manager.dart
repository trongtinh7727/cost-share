import 'package:cost_share/model/budget.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:rxdart/rxdart.dart';

class GroupManager extends BaseBloC {
  final GroupRepository _groupRepository;
  final ExpenseRepository _expenseRepository;
  final BudgetRepository _budgetRepository;

  GroupManager(
      this._groupRepository, this._expenseRepository, this._budgetRepository);

  String currentGroupId = "";
  GroupDetail? get currentGroup => _userGroupsSubject.value
      .firstWhere((element) => element.groupId == currentGroupId);

  final _userGroupsSubject = BehaviorSubject<List<GroupDetail>>();
  final _groupExpensesSubject = BehaviorSubject<List<Expense>>();
  final _groupBudgetSubject = BehaviorSubject<List<Budget>>();

  Stream<List<Expense>> get groupExpensesStream => _groupExpensesSubject.stream;
  Stream<List<GroupDetail>> get userGroupsStream => _userGroupsSubject.stream;
  Stream<List<Budget>> get groupBudgetStream => _groupBudgetSubject.stream;

  Future<void> loadUserGroups(String userId) async {
    try {
      _userGroupsSubject.addStream(_groupRepository.getUserGroups(userId));
    } catch (e) {
      print('Error loading user groups: $e');
    }
  }

  void setCurrentGroup(String groupId) {
    currentGroupId = groupId;
    loadGroupExpenses(groupId);

    // Get the current date
    DateTime now = DateTime.now();

    // Extract the current month and year
    String month = now.month.toString().padLeft(2, '0'); // Format month as MM
    String year = now.year.toString(); // Get the year as YYYY

    // Load group budget with the current month and year
    loadGroupBudget(groupId, month, year);
  }

  @override
  void dispose() {
    _userGroupsSubject.close();
    _groupBudgetSubject.close();
    _groupExpensesSubject.close();
  }

  @override
  void init() {}

  void loadGroupExpenses(String groupId) {
    _groupExpensesSubject
        .addStream(_expenseRepository.getExpensesStream(groupId));
  }

  void loadGroupBudget(String groupId, String month, String year) {
    _groupBudgetSubject
        .addStream(_budgetRepository.loadMonthlyBudget(groupId, month, year));
  }
}
