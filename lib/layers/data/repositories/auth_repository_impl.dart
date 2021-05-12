

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_flow_task/commons/exceptions/exceptions.dart';
import 'package:fresh_flow_task/commons/network/network_info.dart';
import 'package:fresh_flow_task/layers/data/datasources/auth_local_data_source.dart';
import 'package:fresh_flow_task/layers/data/datasources/auth_remote_data_source.dart';
import 'package:fresh_flow_task/layers/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthLocalDatasource authLocalDatasource;
  final AuthRemoteDatasource authRemoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    this.authLocalDatasource,
    this.authRemoteDatasource,
    this.networkInfo
});

  

  @override
  Future<String> login(String email, String password) async{
    // TODO: implement login
    bool isNetworkConnected = await networkInfo.isConnected;
    if(isNetworkConnected){
      try {
        UserCredential userCredential = await authRemoteDatasource.loginUser(
            email, password
        );

        print(userCredential);

        return await authLocalDatasource.cacheUser(userCredential.user.email);
      } on FirebaseAuthException catch (e) {
        throw ServerException();
      }
    }else{
      return authLocalDatasource.getLoggedInUser();
    }

    return null;
  }

  @override
  Future<void> logout() async{
    bool isNetworkConnected = await networkInfo.isConnected;
    if(isNetworkConnected){
      await authRemoteDatasource.logout();
      authLocalDatasource.logOutCacheUser();
    }else{
      authLocalDatasource.logOutCacheUser();
    }
  }

  @override
  bool isLoggedIn()  {
    return authLocalDatasource.getLoggedInUser() != null;
  }

}