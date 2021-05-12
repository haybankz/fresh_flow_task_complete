import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/domain/usecases/get_cache_user.dart';
import 'package:fresh_flow_task/layers/domain/usecases/login_usecase.dart';
import 'package:fresh_flow_task/layers/domain/usecases/logout_usecase.dart';

class AuthNotifier extends ChangeNotifier {

  Login _login;
  Logout _logout;
  GetCacheUser _getCacheUser;

  AuthNotifier({
    @required login, @required logout,
    @required getCacheUser
  }){
    _login = login;
    _logout = logout;
    _getCacheUser = getCacheUser;
  }

  bool isLoading = false;
  String userEmail;
  String error;

  Future<void> loginUser(String email, String password) async{
    isLoading = true;
    userEmail = null;
    error = null;
    notifyListeners();

    try {

      userEmail = await _login.call(email, password);
      // notifyListeners();


    }catch(e){

      error = "error";
    }

    isLoading = false;
    // notify UI
    notifyListeners();
  }

  Future<void> logOut() async{
    isLoading = true;
    notifyListeners();

    try {

       await _logout.call();


    }catch(e){

      error = "error";
    }

    isLoading = false;
    // notify UI
    notifyListeners();
  }

  bool isUserLoggedIn(){
    return _getCacheUser.call();
  }

}