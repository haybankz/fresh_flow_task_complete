import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/data/datasources/remote_datasource.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';

class RemoteDatasourceImpl implements RemoteDatasource {

  final FirebaseFirestore fireCloud;

  RemoteDatasourceImpl({@required this.fireCloud});

  @override
  Future<List<ItemModel>> getAllItems() {
    // TODO: implement getAllItems
    throw UnimplementedError();
  }

}