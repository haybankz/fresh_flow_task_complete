import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/repositories/auth_repository.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';

class GetCacheUser {
  final AuthRepository authRepository;

  GetCacheUser({@required this.authRepository});

  bool call() {
    return authRepository.isLoggedIn();
  }
}