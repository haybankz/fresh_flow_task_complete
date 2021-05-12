import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/repositories/auth_repository.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout({@required this.authRepository});

  Future<void> call() {
    return authRepository.logout();
  }
}