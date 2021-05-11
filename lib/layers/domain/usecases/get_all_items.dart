import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';

class GetAllItems {
  final ItemRepository itemRepository;

  GetAllItems({@required this.itemRepository});

  Stream<List<Item>> call() {
    return itemRepository.getAllItems();
  }
}