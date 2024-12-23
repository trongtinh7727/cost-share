import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:rxdart/rxdart.dart';

class GroupManager extends BaseBloC {
  final GroupRepository _groupRepository;
  final ExpenseRepository _expenseRepository;

  GroupManager(this._groupRepository, this._expenseRepository);

  String currentGroupId = "";
  GroupDetail? get currentGroup => _userGroupsSubject.value
      .firstWhere((element) => element.groupId == currentGroupId);

  final _userGroupsSubject = BehaviorSubject<List<GroupDetail>>();
  final _groupExpensesSubject = BehaviorSubject<List<Expense>>();

  Stream<List<Expense>> get groupExpensesStream => _groupExpensesSubject.stream;
  Stream<List<GroupDetail>> get userGroupsStream => _userGroupsSubject.stream;

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
  }

  @override
  void dispose() {
    _userGroupsSubject.close();
  }

  @override
  void init() {}

  void loadGroupExpenses(String groupId) {
    _groupExpensesSubject
        .addStream(_expenseRepository.getExpensesStream(groupId));
  }
}
