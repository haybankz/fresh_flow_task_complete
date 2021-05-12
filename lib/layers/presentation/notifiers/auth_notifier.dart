import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/domain/usecases/login_usecase.dart';
import 'package:fresh_flow_task/layers/domain/usecases/logout_usecase.dart';

class AuthNotifier extends ChangeNotifier {

  final Login login;
  final Logout logout;

  AuthNotifier({
    @required this.login, @required this.logout
  });

  bool isLoading = false;
  String userEmail;
  String error;

  Future<void> loginUser(String email, String password) async{
    isLoading = true;
    notifyListeners();

    try {

      userEmail = await login.call(email, password);


    }catch(e){

      error = "error";
    }

    isLoading = false;
    // notify UI
    notifyListeners();
  }

  Future<void> loginOut() async{
    isLoading = true;
    notifyListeners();

    try {

       await logout.call();


    }catch(e){

      error = "error";
    }

    isLoading = false;
    // notify UI
    notifyListeners();
  }

}