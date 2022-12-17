import 'package:flutter/services.dart';
import 'package:test/test.dart';
import 'package:todo/services/auth/auth_enceptions.dart';
import 'package:todo/services/auth/auth_provider.dart';
import 'package:todo/services/auth/auth_user.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be init to begin with', () {
      expect(provider.isInitialized, false);
    });

    test("not logged out is not initzed", () {
      expect(provider.logout(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });

    test("showuld be able to init", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test("user should be null after init", () {
      expect(provider.currentUser, null);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == "foo@bar.com") throw UserNotFoundAuthException();
    if (password == "foobar") throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
