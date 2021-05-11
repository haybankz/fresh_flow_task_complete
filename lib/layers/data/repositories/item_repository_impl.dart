import 'package:fresh_flow_task/layers/data/datasources/local_datasource.dart';
import 'package:fresh_flow_task/layers/data/datasources/remote_datasource.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {

  final LocalDatasource localDatasource;
  final RemoteDatasource remoteDatasource;

  ItemRepositoryImpl({
    this.localDatasource,
    this.remoteDatasource
});

  @override
  Stream<List<Item>> getAllItems() {
    // TODO: implement getAllItems
    throw UnimplementedError();
  }

}