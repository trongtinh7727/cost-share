import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/split.dart';
import 'package:cost_share/model/user.dart';
import 'package:cost_share/model/user_split.dart';

abstract class ExpenseRepository {
  Future<Expense> addExpense(Expense expense);
  Future<void> addSplits(List<Split> splits);

  Future<void> deleteExpense(String expenseId);
  Future<List<Expense>> getGroupExpenses(String groupId);
  Stream<List<Expense>> getExpensesStream(String groupId);
  Future<List<Split>> getExpenseSplits(String expenseId);
  Future<List<UserSplit>> getExpenseUserSplits(String expenseId);
  Future<void> updateSplit(Split splitData);
  Future<void> updateExpense(Expense expense, double oldAmount);
}

class ExpenseRepositoryImpl extends ExpenseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Expense> addExpense(Expense expense) async {
    try {
      DocumentReference expenseRef =
          await _firestore.collection('expenses').add(expense.toJson());

      // Update the totalExpense of the group
      await _firestore.runTransaction((transaction) async {
        DocumentReference groupRef =
            _firestore.collection('groups').doc(expense.groupId);
        DocumentSnapshot groupSnapshot = await transaction.get(groupRef);

        if (!groupSnapshot.exists) {
          throw Exception('Group does not exist');
        }

        double currentTotalExpense =
            groupSnapshot.get('totalExpense') * 1.0 ?? 0.0;
        double newTotalExpense = currentTotalExpense + expense.amount;

        transaction.update(groupRef, {'totalExpense': newTotalExpense});
      });

      return expense.copyWith(id: expenseRef.id);
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  @override
  Future<void> addSplits(List<Split> splits) async {
    try {
      WriteBatch batch = _firestore.batch();
      for (Split split in splits) {
        DocumentReference splitRef = _firestore.collection('splits').doc();
        batch.set(splitRef, split.toJson());
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to add splits: $e');
    }
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    try {
      DocumentReference expenseRef =
          _firestore.collection('expenses').doc(expenseId);
      DocumentSnapshot expenseSnapshot = await expenseRef.get();

      if (!expenseSnapshot.exists) {
        throw Exception('Expense does not exist');
      }

      Expense expense =
          Expense.fromJson(expenseSnapshot.data() as Map<String, dynamic>);

      // Delete the expense
      await expenseRef.delete();

      QuerySnapshot splitsSnapshot = await _firestore
          .collection('splits')
          .where('expenseId', isEqualTo: expenseId)
          .get();

      splitsSnapshot.docs.forEach((splitDoc) {
        splitDoc.reference.delete();
      });

      // Update the totalExpense of the group
      await _firestore.runTransaction((transaction) async {
        DocumentReference groupRef =
            _firestore.collection('groups').doc(expense.groupId);
        DocumentSnapshot groupSnapshot = await transaction.get(groupRef);

        if (!groupSnapshot.exists) {
          throw Exception('Group does not exist');
        }

        double currentTotalExpense =
            groupSnapshot.get('totalExpense') * 1.0 ?? 0.0;
        double newTotalExpense = currentTotalExpense - expense.amount;

        transaction.update(groupRef, {'totalExpense': newTotalExpense});
      });
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

  @override
  Stream<List<Expense>> getExpensesStream(String groupId) {
    try {
      return _firestore
          .collection('expenses')
          .where('groupId', isEqualTo: groupId)
          .orderBy('date', descending: true)
          .snapshots()
          .asyncMap((snapshot) async {
        List<Expense> expenses = [];
        for (var doc in snapshot.docs) {
          var expense = Expense.fromJson(doc.data());
          expense = expense.copyWith(id: doc.id);
          var userSnapshot =
              await _firestore.collection('users').doc(expense.userId).get();
          if (userSnapshot.exists) {
            var userData = userSnapshot.data()!;
            expense = expense.copyWith(
              avatarUrl: userData['photoUrl'],
              name: userData['name'],
            );
          }
          expenses.add(expense);
        }
        return expenses;
      });
    } catch (e) {
      throw Exception('Failed to fetch expense stream: $e');
    }
  }

  @override
  Future<List<Split>> getExpenseSplits(String expenseId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> splitSnapshot = await _firestore
          .collection('splits')
          .where('expenseId', isEqualTo: expenseId)
          .get();

      return splitSnapshot.docs
          .map((doc) => Split.fromJson(doc.data()).copyWith(id: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch splits: $e');
    }
  }

  @override
  Future<void> updateSplit(Split splitData) {
    try {
      DocumentReference splitRef =
          _firestore.collection('splits').doc(splitData.id);
      return splitRef.update(splitData.toJson());
    } catch (e) {
      throw Exception('Failed to update split: $e');
    }
  }

  @override
  Future<List<UserSplit>> getExpenseUserSplits(String expenseId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> splitSnapshot = await _firestore
          .collection('splits')
          .where('expenseId', isEqualTo: expenseId)
          .get();

      List<Split> splits = splitSnapshot.docs
          .map((doc) => Split.fromJson(doc.data()).copyWith(id: doc.id))
          .toList();

      List<Future<UserSplit>> userSplitFutures = splits.map((split) async {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await _firestore.collection('users').doc(split.userId).get();

        if (!userSnapshot.exists) {
          throw Exception('User not found for userId: ${split.userId}');
        }

        final userData = userSnapshot.data();

        return UserSplit.formUser(User.fromJson(userData!).copyWith(
          id: split.userId,
        )).copyWith(
          amount: split.amount,
          ratio: split.ratio,
          isPaid: split.isPaid,
          splitId: split.id,
          expenseId: split.expenseId,
        );
      }).toList();

      List<UserSplit> userSplits = await Future.wait(userSplitFutures);

      return userSplits;
    } catch (e) {
      throw Exception('Failed to fetch splits: $e');
    }
  }

  @override
  Future<void> updateExpense(Expense expense, double oldAmount) async {
    try {
      DocumentReference expenseRef =
          _firestore.collection('expenses').doc(expense.id);

      // Update the totalExpense of the group
      await _firestore.runTransaction((transaction) async {
        DocumentReference groupRef =
            _firestore.collection('groups').doc(expense.groupId);
        DocumentSnapshot groupSnapshot = await transaction.get(groupRef);

        if (!groupSnapshot.exists) {
          throw Exception('Group does not exist');
        }

        double currentTotalExpense =
            groupSnapshot.get('totalExpense') * 1.0 ?? 0.0;
        double newTotalExpense =
            currentTotalExpense + expense.amount - oldAmount;

        transaction.update(groupRef, {'totalExpense': newTotalExpense});
      });

      return expenseRef.update(expense.toJson());
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }
}