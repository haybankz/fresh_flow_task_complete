import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);

  Future<void> logout();

  bool isLoggedIn();
}