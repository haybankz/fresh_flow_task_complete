import 'package:fresh_flow_task/layers/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();
}