import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/data/datasources/local_datasource.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasourceImpl implements LocalDatasource{

  final SharedPreferences sharedPreferences;

  LocalDatasourceImpl({@required this.sharedPreferences});

  @override
  Future<List<ItemModel>> cacheItemList(List<ItemModel> list) {
    // TODO: implement cacheItemList
    throw UnimplementedError();
  }

  @override
  Future<List<ItemModel>> getItems() {
    // TODO: implement getItems
    throw UnimplementedError();
  }

}