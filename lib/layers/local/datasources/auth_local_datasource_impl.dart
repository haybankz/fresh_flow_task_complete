import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/data/datasources/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasourceImpl extends AuthLocalDatasource {

  final SharedPreferences sharedPreferences;

  AuthLocalDatasourceImpl({@required this.sharedPreferences});
  
  @override
  Future<String> cacheUser(String userEmail) async{
    await sharedPreferences.setString('email', userEmail);

    return userEmail;
  }

  @override
  String getLoggedInUser() {
    return sharedPreferences.getString('email');
  }

  @override
  Future<void> logOutCacheUser() async{
    await sharedPreferences.setString('email', null);
  }
}