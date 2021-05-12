
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_flow_task/commons/network/network_info.dart';
import 'package:fresh_flow_task/layers/data/datasources/local_datasource.dart';
import 'package:fresh_flow_task/layers/data/datasources/remote_datasource.dart';
import 'package:fresh_flow_task/layers/data/repositories/item_repository_impl.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/fake/item_data_fake_factory.dart';


class NetworkInfoMock extends Mock implements NetworkInfo {}

class LocalDatasourceMock extends Mock
    implements LocalDatasource {}

class RemoteDatasourceMock extends Mock
    implements RemoteDatasource {}



ItemRepository itemRepository;
NetworkInfoMock networkInfoMock;
LocalDatasourceMock localDatasource;
RemoteDatasourceMock networkDatasource;

final testItemData = ItemModelFakeFactory.createList(size: 10);

void main() {
  setUp(() {
    networkInfoMock = NetworkInfoMock();
    localDatasource = LocalDatasourceMock();
    networkDatasource = RemoteDatasourceMock();

    itemRepository = ItemRepositoryImpl(
      networkInfo: networkInfoMock,
      localDatasource: localDatasource,
      remoteDatasource: networkDatasource,
    );
  });

  runOnlineScenarioTests();

}

void runOnlineScenarioTests() {
  group('Given an Online Device', () {
    setUp(() {
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
    });

    group('With an EMPTY Memory Cache', () {


      test(
        'It should check when device is online',
        () async {
          // act
          await itemRepository.getAllItems();

          // assert
          verify(networkInfoMock.isConnected);
        },
      );

      test(
        'It should fetch data from the network',
        () async {
          // arrange
          when(networkDatasource.getAllItems())
              .thenAnswer((_) async => testItemData);

          // act
          final result = await itemRepository.getAllItems();

          // assert
          expect(result, testItemData);
          verify(networkDatasource.getAllItems());
        },
      );

      test(
        'It should update Local Storage',
        () async {
          // arrange
          when(networkDatasource.getAllItems())
              .thenAnswer((_) async => testItemData);

          // act
          final result = await itemRepository.getAllItems();

          // assert
          expect(result, testItemData);
          verify(localDatasource.cacheItemList(testItemData));
        },
      );


    });


  });
}


