import 'package:fresh_flow_task/layers/data/models/item_model.dart';

abstract class RemoteDatasource {

  Future<List<ItemModel>> getAllItems();
}