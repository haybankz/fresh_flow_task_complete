import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';

abstract class ItemRemoteDatasource {

  Future<List<ItemModel>> getAllItems();

}