import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/generated/l10n.dart';
import 'package:cost_share/model/group.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/model/user.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/utils/enum/app_wallet.dart';
import 'package:flutter/material.dart';

abstract class GroupRepository {
  Future<Group> createGroup(Group group);
  Future<void> deleteGroup(String groupId);
  Stream<List<UserSplit>> getGroupMembers(String groupId);
  Stream<Group?> getGroupById(String groupId);
  Stream<List<GroupDetail>> getUserGroups(String userId);
  Future<void> removeMember(String groupId, String? userId);

  Future<void> addMember(String groupId, String email, BuildContext context);

  Future<double> getTotalDebt(String groupId, String userId, String? userId2);
  Future<void> markAsPaid(String groupId, String userId, String userId2);
}

class GroupRepositoryImpl extends GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Group> createGroup(Group group) async {
    try {
      Map<String, dynamic> groupJson = group.toJson();
      DocumentReference groupRef =
          await _firestore.collection('groups').add(groupJson);
      return group.copyWith(id: groupRef.id);
    } catch (e) {
      throw Exception('Failed to create group: $e');
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      await _firestore.collection('groups').doc(groupId).delete();
    } catch (e) {
      throw Exception('Failed to delete group: $e');
    }
  }

  @override
  Stream<Group?> getGroupById(String groupId) {
    try {
      return _firestore
          .collection('groups')
          .doc(groupId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return Group.fromJson(snapshot.data()!).copyWith(id: snapshot.id);
        }
        return null; // Document does not exist
      });
    } catch (e) {
      throw Exception('Failed to fetch group: $e');
    }
  }

  @override
  Stream<List<GroupDetail>> getUserGroups(String userId) {
    try {
      return _firestore
          .collection('groups')
          .where('members', arrayContainsAny: [
            {'role': 'OWNER', 'userId': userId},
            {'role': 'MEMBER', 'userId': userId}
          ])
          .snapshots()
          .asyncMap((groupsQuery) async {
            List<GroupDetail> groupDetails = [];
            for (var groupDoc in groupsQuery.docs) {
              final groupData = groupDoc.data();

              // Get the creator's details
              final creatorDoc = await _firestore
                  .collection('users')
                  .doc(groupData['createdBy'])
                  .get();
              final creatorData = creatorDoc.data();

              // Construct group detail object
              groupDetails.add(GroupDetail(
                  groupId: groupDoc.id,
                  groupName: groupData['name'],
                  groupPhoto: groupData['groupPhoto'] ?? '',
                  memberCount: (groupData['members'] as List).length,
                  authorId: creatorData?['id'] ?? 'Unknown',
                  authorName: creatorData?['name'] ?? 'Unknown',
                  authorPhoto: creatorData?['photoUrl'] ?? '',
                  totalBudget: groupData['totalBudget'] * 1.0,
                  totalExpense: groupData['totalBudget'] * 1.0));
            }
            return groupDetails;
          });
    } catch (e) {
      throw Exception('Failed to fetch user groups: $e');
    }
  }

  @override
  Stream<List<UserSplit>> getGroupMembers(String groupId) {
    try {
      return _firestore
          .collection('groups')
          .doc(groupId)
          .snapshots()
          .asyncMap((snapshot) async {
        if (!snapshot.exists) {
          throw Exception('Group not found');
        }

        final groupData = snapshot.data();
        if (groupData == null || groupData['members'] == null) {
          return [];
        }

        final members = (groupData['members'] as List)
            .map((e) => Member.fromJson(e))
            .toList();

        // Fetch user information for each member in parallel
        return Future.wait(
          members.map((member) async {
            final userSnapshot =
                await _firestore.collection('users').doc(member.userId).get();

            if (!userSnapshot.exists) {
              throw Exception('User not found for userId: ${member.userId}');
            }

            final userData = userSnapshot.data();
            return UserSplit.formUser(
                User.fromJson(userData!).copyWith(id: userSnapshot.id));
          }),
        );
      });
    } catch (e) {
      throw Exception('Failed to fetch group members: $e');
    }
  }

  @override
  Future<void> removeMember(String groupId, String? userId) {
    try {
      return _firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayRemove([
          {'role': 'MEMBER', 'userId': userId}
        ])
      });
    } catch (e) {
      throw Exception('Failed to remove member: $e');
    }
  }

  @override
  Future<void> addMember(
      String groupId, String email, BuildContext context) async {
    try {
      // Fetch the user by email
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception(AppLocalizations.of(context).userNotFound);
      }

      // Get the user ID from the fetched user document
      String userId = userSnapshot.docs.first.id;

      // Add the user to the group
      await _firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion([
          {'role': 'MEMBER', 'userId': userId}
        ])
      });
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<double> getTotalDebt(
      String groupId, String userId, String? userId2) async {
    try {
      double totalDebt = 0.0;

      // Fetch expenses paid by the user
      QuerySnapshot expensesSnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: userId)
          .where('groupId', isEqualTo: groupId)
          .where('paidBy', isEqualTo: AppWallet.PERSONAL.name)
          .get();

      // Fetch splits for each expense in parallel
      List<Future<QuerySnapshot>> splitFutures =
          expensesSnapshot.docs.map((expenseDoc) {
        return _firestore
            .collection('splits')
            .where('userId', isEqualTo: userId2)
            .where('expenseId', isEqualTo: expenseDoc.id)
            .where('isPaid', isEqualTo: false)
            .get();
      }).toList();

      List<QuerySnapshot> splitsSnapshots = await Future.wait(splitFutures);

      // Calculate total debt
      for (var splitsSnapshot in splitsSnapshots) {
        for (var splitDoc in splitsSnapshot.docs) {
          totalDebt += splitDoc['amount'];
        }
      }

      return totalDebt;
    } catch (e) {
      throw Exception('Failed to get total debt: $e');
    }
  }

  @override
  Future<void> markAsPaid(String groupId, String userId, String userId2) async {
    try {
      QuerySnapshot expensesSnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: userId)
          .where('groupId', isEqualTo: groupId)
          .where('paidBy', isEqualTo: AppWallet.PERSONAL.name)
          .get();

      for (var expenseDoc in expensesSnapshot.docs) {
        await _markExpenseAsPaid(userId2, expenseDoc.id);
      }
    } catch (e) {
      throw Exception('Failed to mark as paid: $e');
    }
  }

  _markExpenseAsPaid(String userId, String expenseId) {
    try {
      return _firestore
          .collection('splits')
          .where('userId', isEqualTo: userId)
          .where('expenseId', isEqualTo: expenseId)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.forEach((doc) {
            doc.reference.update({'isPaid': true});
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to mark expense as paid: $e');
    }
  }
}
