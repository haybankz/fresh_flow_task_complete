import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/commons/errors/failure.dart';
import 'package:fresh_flow_task/commons/exceptions/exceptions.dart';
import 'package:fresh_flow_task/commons/utils.dart';
import 'package:fresh_flow_task/layers/data/datasources/item_remote_datasource.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';

class ItemRemoteDatasourceImpl implements ItemRemoteDatasource {

  final FirebaseFirestore fireCloud;


  ItemRemoteDatasourceImpl({@required this.fireCloud});

  @override
  Future<List<ItemModel>> getAllItems() async{

    List<ItemModel> list = [];

    try {
      var itemsSnapShot = await fireCloud.collection('items').get();

      for (final doc in itemsSnapShot.docs) {
        debugPrint(doc.data().toString());
        list.add(ItemModel.fromJson(doc.data()));
      }
    }catch(e){
      throw ServerException();
    }

    return list;

  }




}