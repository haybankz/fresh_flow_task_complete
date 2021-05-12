import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/repositories/auth_repository.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';

class Login {
  final AuthRepository authRepository;

  Login({@required this.authRepository});

  Future<String> call(String email, String password) {
    return authRepository.login(email, password);
  }
}