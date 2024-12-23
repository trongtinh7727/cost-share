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

      // Update the totalBudget of the group
      await _firestore.runTransaction((transaction) async {
        DocumentReference groupRef =
            _firestore.collection('groups').doc(budget.groupId);
        DocumentSnapshot groupSnapshot = await transaction.get(groupRef);

        if (!groupSnapshot.exists) {
          throw Exception('Group does not exist');
        }

        double currentTotalBudget = groupSnapshot.get('totalBudget') ?? 0.0;
        double newTotalBudget = currentTotalBudget + budget.totalAmount;

        transaction.update(groupRef, {'totalBudget': newTotalBudget});
      });

      return budget;
    } catch (e) {
      throw Exception('Failed to add or update budget: $e');
    }
  }

  @override
  Future<void> deleteBudget(String budgetId) async {
    try {
      DocumentReference budgetRef =
          _firestore.collection('budgets').doc(budgetId);
      DocumentSnapshot budgetSnapshot = await budgetRef.get();

      if (!budgetSnapshot.exists) {
        throw Exception('Budget does not exist');
      }

      Budget budget = Budget.fromJson(budgetSnapshot.data() as Map<String, dynamic>);

      // Delete the budget
      await budgetRef.delete();

      // Update the totalBudget of the group
      await _firestore.runTransaction((transaction) async {
        DocumentReference groupRef =
            _firestore.collection('groups').doc(budget.groupId);
        DocumentSnapshot groupSnapshot = await transaction.get(groupRef);

        if (!groupSnapshot.exists) {
          throw Exception('Group does not exist');
        }

        double currentTotalBudget = groupSnapshot.get('totalBudget') ?? 0.0;
        double newTotalBudget = currentTotalBudget - budget.totalAmount;

        transaction.update(groupRef, {'totalBudget': newTotalBudget});
      });
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
