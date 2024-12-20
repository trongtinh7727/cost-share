import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/group.dart';

abstract class GroupRepository {
  Future<Group> createGroup(Group group);
  Future<void> deleteGroup(String groupId);
  Stream<Group?> getGroupById(String groupId);
  Stream<List<Map<String, dynamic>>> getUserGroups(String userId);
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
          return Group.fromJson(snapshot.data()!);
        }
        return null; // Document does not exist
      });
    } catch (e) {
      throw Exception('Failed to fetch group: $e');
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getUserGroups(String userId) {
    try {
      return _firestore
          .collection('groups')
          .where('members', arrayContains: {'role':'OWNER','userId': userId})
          .snapshots()
          .asyncMap((groupsQuery) async {
        List<Map<String, dynamic>> groupDetails = [];
        for (var groupDoc in groupsQuery.docs) {
          final groupData = groupDoc.data();

          // Get the creator's details
          final creatorDoc = await _firestore
              .collection('users')
              .doc(groupData['createdBy'])
              .get();
          final creatorData = creatorDoc.data();

          // Construct group detail object
          groupDetails.add({
            'groupName': groupData['name'],
            'groupPhoto': groupData['groupPhoto'] ?? '',
            'memberCount': (groupData['members'] as List).length,
            'authorName': creatorData?['name'] ?? 'Unknown',
            'authorPhoto': creatorData?['photoUrl'] ?? '',
          });
        }
        return groupDetails;
      });
    } catch (e) {
      throw Exception('Failed to fetch user groups: $e');
    }
  }
}
