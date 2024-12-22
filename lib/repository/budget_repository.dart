import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/budget.dart';

abstract class BudgetRepository {
  Future<Budget> addOrUpdateBudget(Budget budget);
  Future<void> deleteBudget(String budgetId);
  Future<List<Budget>> getGroupBudgets(String groupId);
}

class BudgetRepositoryImpl extends BudgetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Budget> addOrUpdateBudget(Budget budget) async {
    try {
      if (budget.id != null && budget.id!.isNotEmpty) {
        // Update the existing document
        await _firestore
            .collection('budgets')
            .doc(budget.id)
            .update(budget.toJson());
      } else {
        // Add a new document
        DocumentReference budgetRef =
            await _firestore.collection('budgets').add(budget.toJson());
        budget = budget.copyWith(id: budgetRef.id);
      }
      return budget;
    } catch (e) {
      throw Exception('Failed to add or update budget: $e');
    }
  }

  @override
  Future<void> deleteBudget(String budgetId) async {
    try {
      await _firestore.collection('budgets').doc(budgetId).delete();
    } catch (e) {
      throw Exception('Failed to delete budget: $e');
    }
  }

  @override
  Future<List<Budget>> getGroupBudgets(String groupId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> budgetSnapshot = await _firestore
          .collection('budgets')
          .where('groupId', isEqualTo: groupId)
          .get();

      return budgetSnapshot.docs
          .map((doc) => Budget.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch budgets: $e');
    }
  }
}
