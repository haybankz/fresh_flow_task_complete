import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/usecases/get_all_items.dart';

class ItemNotifier extends ChangeNotifier {
  final GetAllItems _getAllItems;

  ItemNotifier({
    @required GetAllItems getAllItems,
  }) : _getAllItems = getAllItems;

  bool isLoading = false;
  List<Item> itemsList;
  String error;

  Future<void> fetchAllItems() async {
    // show loading
    isLoading = true;
    notifyListeners();

    try {
      // Fetch the list
      itemsList = await _getAllItems.call();

    }catch(e){

      error = "error while loading";
    }

    isLoading = false;
    // notify UI
    notifyListeners();
  }
}