import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

abstract class UserRepository {
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<User> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<User?> getCurrentUser();
}

class UserRepositoryImpl extends UserRepository {
  final fb_auth.FirebaseAuth _firebaseAuth = fb_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Creates a new user account with email and password.
  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create Firebase Auth user
      fb_auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add the user to Firestore with the custom User model
      User newUser = User(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        groups: [], // Empty list initially
        photoUrl: null,
      );

      await _firestore
          .collection('users')
          .doc(newUser.id)
          .set(newUser.toJson());
    } on fb_auth.FirebaseAuthException catch (e) {
      // Pass only the error message
      throw fb_auth.FirebaseAuthException(
        code: e.code,
        message: e.message, // Firebase provides human-readable messages
      );
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  /// Logs in the user with email and password.
  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      fb_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Fetch user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        return User.fromJson(userDoc.data()!);
      } else {
        throw Exception('User data not found in Firestore');
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Gets the current signed-in user (if any).
  @override
  Future<User?> getCurrentUser() async {
    try {
      fb_auth.User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();

        if (userDoc.exists) {
          return User.fromJson(userDoc.data()!);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch current user: $e');
    }
  }
}
