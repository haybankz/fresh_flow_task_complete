
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_flow_task/layers/domain/repositories/item_repository.dart';
import 'package:fresh_flow_task/layers/domain/usecases/get_all_items.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/fake/items_fake_factory.dart';

class ItemRepositoryMock extends Mock implements ItemRepository {}

void main() {
  GetAllItems getAllItems;
  ItemRepositoryMock itemRepositoryMock;

  setUp(() {
    itemRepositoryMock = ItemRepositoryMock();
    getAllItems = GetAllItems(
      itemRepository: itemRepositoryMock,
    );
  });

  final testCharacters = ItemFakeFactory.createList(size: 10);

  test(
    'it should fetch a list of characters from CharacterRepository',
    () async {
      // arrange
      when(itemRepositoryMock.getAllItems())
          .thenAnswer((realInvocation) async => testCharacters);

      // act
      final result = await getAllItems();

      // assert
      expect(result, testCharacters);
      verify(itemRepositoryMock.getAllItems());
      verifyNoMoreInteractions(itemRepositoryMock);
    },
  );
}
