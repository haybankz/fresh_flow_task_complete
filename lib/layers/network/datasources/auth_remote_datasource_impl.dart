import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/commons/exceptions/exceptions.dart';
import 'package:fresh_flow_task/layers/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {


  final FirebaseAuth fireAuth;

  AuthRemoteDatasourceImpl({@required this.fireAuth});


  @override
  Future<UserCredential> loginUser(String email, String password) async{
    UserCredential credential;
    try {
      credential = await fireAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      throw ServerException();
    }
    return credential;
  }

  @override
  Future<void> logout() async{

    try {

      await fireAuth.signOut();

    }catch(e){

      throw ServerException();
    }

  }


}