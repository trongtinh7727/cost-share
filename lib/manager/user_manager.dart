import 'dart:async';
import 'package:cost_share/model/user.dart';
import 'package:cost_share/repository/user_repository.dart';
import 'package:cost_share/service/firebase_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserManager {
  final UserRepository _userRepository;
  final BehaviorSubject<Locale?> _localeStream = BehaviorSubject<Locale?>();
  final BehaviorSubject<User?> _userStream = BehaviorSubject<User?>();

  UserManager(this._userRepository);

  // Locale Stream for observing and updating app locale
  Stream<Locale?> get localeStream => _localeStream.stream;

  // User Stream for observing and updating user data
  Stream<User?> get userStream => _userStream.stream;

  // Getter for current locale
  Locale? get currentLocale => _localeStream.valueOrNull;

  // Getter for current user
  User? get currentUser => _userStream.valueOrNull;

  // Set new locale and notify listeners
  Future<void> setLocale(Locale locale) async {
    _localeStream.add(locale);
  }

  Future<void> loadUser() async {
    try {
      final user = await _userRepository.getCurrentUser();
      _userStream.add(user);
      debugPrint('Success loading user: ${user?.email ?? 'None'}');
      String? token = FirebaseMessagingService().instance.token ?? '';
      // Update FCM token
      _userRepository.updateUserData(user!.copyWith(fcmToken: token));
    } catch (e) {
      debugPrint('Error loading user: $e');
      _userStream.add(null);
    }
  }

  void signOut() {
    final user = currentUser;

    // Update FCM token
    user?.copyWith(fcmToken: '');
    _userRepository.updateUserData(user!);
    _userStream.add(null);
    _userRepository.signOut();
  }

  // Clear streams when disposing
  void dispose() {
    _localeStream.close();
    _userStream.close();
  }
}
