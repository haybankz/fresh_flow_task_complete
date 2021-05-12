import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDatasource {

  Future<UserCredential> loginUser(String email, String password);

  Future<void> logout();
}