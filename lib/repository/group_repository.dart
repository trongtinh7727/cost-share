import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/group.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/model/member.dart';
import 'package:cost_share/model/user.dart';
import 'package:cost_share/model/user_split.dart';

abstract class GroupRepository {
  Future<Group> createGroup(Group group);
  Future<void> deleteGroup(String groupId);
  Stream<List<UserSplit>> getGroupMembers(String groupId);
  Stream<Group?> getGroupById(String groupId);
  Stream<List<GroupDetail>> getUserGroups(String userId);
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
                authorName: creatorData?['name'] ?? 'Unknown',
                authorPhoto: creatorData?['photoUrl'] ?? '',
              ));
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
}
