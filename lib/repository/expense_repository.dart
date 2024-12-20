import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/expense.dart';

abstract class ExpenseRepository {
  Future<Expense> addExpense(Expense expense);
  Future<void> deleteExpense(String expenseId);
  Future<List<Expense>> getGroupExpenses(String groupId);
}

class ExpenseRepositoryImpl extends ExpenseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Expense> addExpense(Expense expense) async {
    try {
      DocumentReference expenseRef =
          await _firestore.collection('expenses').add(expense.toJson());
      return expense.copyWith(id: expenseRef.id);
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    try {
      await _firestore.collection('expenses').doc(expenseId).delete();
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  @override
  Future<List<Expense>> getGroupExpenses(String groupId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> expenseSnapshot = await _firestore
          .collection('expenses')
          .where('groupId', isEqualTo: groupId)
          .get();

      return expenseSnapshot.docs
          .map((doc) => Expense.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }
}
