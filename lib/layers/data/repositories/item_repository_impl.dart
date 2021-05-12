import 'package:fresh_flow_task/commons/network/network_info.dart';
import 'package:fresh_flow_task/layers/data/datasources/local_datasource.dart';
import 'package:fresh_flow_task/layers/data/datasources/remote_datasource.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {

  final LocalDatasource localDatasource;
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ItemRepositoryImpl({
    this.localDatasource,
    this.remoteDatasource,
    this.networkInfo
});

  @override
  Future<List<Item>> getAllItems() async {
    // TODO: implement getAllItems
    bool isNetworkConnected = await networkInfo.isConnected;
    if(isNetworkConnected) {
      List<Item> items = await remoteDatasource.getAllItems();
      if (items.length > 0) {
        //TODO save items to localDB
        localDatasource.cacheItemList(items);
      }

      return items;
    }else{
      return localDatasource.getItems();
    }


  }

}