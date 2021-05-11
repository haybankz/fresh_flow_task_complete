import 'package:fresh_flow_task/layers/data/models/item_model.dart';

abstract class LocalDatasource {
  /// Get the latest [List<ItemModel>] cached when internet was available
  ///
  /// Throws a [List<ItemMode>] if no cached data is present.
  Future<List<ItemModel>> getItems();

  /// Caches a [List<ItemModel>] cached when internet was available
  ///
  /// Throws a [List<ItemModel>] if no cached data is present.
  Future<List<ItemModel>> cacheItemList(List<ItemModel> list);
}