import 'package:fresh_flow_task/layers/domain/entities/item.dart';

abstract class ItemRepository {
  Stream<List<Item>> getAllItems();
}