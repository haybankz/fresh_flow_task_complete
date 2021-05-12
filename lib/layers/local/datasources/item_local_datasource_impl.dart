import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/data/datasources/item_local_datasource.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemLocalDatasourceImpl implements ItemLocalDatasource{

  final SharedPreferences sharedPreferences;

  ItemLocalDatasourceImpl({@required this.sharedPreferences});

  @override
  Future<List<ItemModel>> cacheItemList(List<ItemModel> list) async{
    String json = jsonEncode(list.map((e) => e.toJson()).toList());
    await sharedPreferences.setString('items', json);

    return list;
  }

  @override
  List<ItemModel> getItems() {
   String itemString = sharedPreferences.getString('items') ?? '';

   if(itemString.isNotEmpty) {
     Iterable l = json.decode(itemString);
     List<ItemModel> items = List<ItemModel>.from(
         l.map((model) => ItemModel.fromJson(model)));

     return items;
   }
   return List.empty();
  }



}