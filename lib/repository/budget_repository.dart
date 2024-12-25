import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/budget.dart';

abstract class BudgetRepository {
  Future<Budget> addOrUpdateBudget(Budget budget);
  Future<void> deleteBudget(String budgetId);
  Future<List<Budget>> getGroupBudgets(String groupId);
  Stream<List<Budget>> loadMonthlyBudget(
      String groupId, String month, String year);
}

class BudgetRepositoryImpl extends BudgetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Budget> addOrUpdateBudget(Budget budget) async {
    try {
      await _firestore
          .collection('budgets')
          .doc(budget.id)
          .set(budget.toJson());

      // Update the totalBudget of the group
      await _firestore.runTransaction((transaction) async {
        DocumentReference groupRef =
            _firestore.collection('groups').doc(budget.groupId);
        DocumentSnapshot groupSnapshot = await transaction.get(groupRef);

        if (!groupSnapshot.exists) {
          throw Exception('Group does not exist');
        }

        double currentTotalBudget =
            groupSnapshot.get('totalBudget') * 1.0 ?? 0.0;
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

      Budget budget =
          Budget.fromJson(budgetSnapshot.data() as Map<String, dynamic>);

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

        double currentTotalBudget =
            groupSnapshot.get('totalBudget') * 1.0 ?? 0.0;
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

  @override
  Stream<List<Budget>> loadMonthlyBudget(
      String groupId, String month, String year) {
    return _firestore
        .collection('budgets')
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snapshot) {
      // Extract budgets that match the specified month and year
      return snapshot.docs
          .map((doc) => Budget.fromJson(doc.data()))
          .where((budget) {
        // Assuming budget.id contains month and year
        return budget.id!.contains('$month$year'); // Ensure id format matches
      }).toList();
    });
  }
}
