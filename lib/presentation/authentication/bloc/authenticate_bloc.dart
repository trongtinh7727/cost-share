import 'package:cost_share/repository/user_repository.dart';
import 'package:cost_share/utils/BaseBloC.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticateBloc extends BaseBloC {
  final UserRepository _userRepository;

  AuthenticateBloc({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  String _email = '';
  String get email => _email;

  String _fullName = '';
  String get fullName => _fullName;

  final BehaviorSubject<String> passwordController = BehaviorSubject<String>();
  final BehaviorSubject<bool> _loadingController =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String?> _errorController = BehaviorSubject<String?>();

  String get _password => passwordController.valueOrNull ?? '';

  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<String?> get errorStream => _errorController.stream;

  void onChangeEmail(String email) {
    _email = email;
  }

  void onChangeFullName(String fullName) {
    _fullName = fullName;
  }

  void onPassChanged(String password) {
    passwordController.sink.add(password);
  }

  Future<void> signUp() async {
    _loadingController.sink.add(true);
    _errorController.sink.add(null);

    try {
      await _userRepository.signUp(
        name: _fullName,
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      _errorController.sink.add(e.message);
    } catch (e) {
      _errorController.sink.add(e.toString());
    } finally {
      _loadingController.sink.add(false);
    }
  }

  Future<void> signIn() async {
    _loadingController.sink.add(true);
    _errorController.sink.add(null);

    try {
      await _userRepository.signIn(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      _errorController.sink.add(e.message);
    } catch (e) {
      _errorController.sink.add(e.toString());
    } finally {
      _loadingController.sink.add(false);
    }
  }

  @override
  void dispose() {
    passwordController.close();
    _loadingController.close();
    _errorController.close();
  }

  @override
  void init() {
    _loadingController.add(false);
    _errorController.add('');
  }
}
