
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/domain/entities/item.dart';

class ItemFakeFactory {
  static Item create({

    String name,
    String price,
    String url
  }) {
    return Item(

        name: name ?? faker.person.firstName(),
        price: price ?? faker.randomGenerator.integer(1000).toString(),
        url: url ?? faker.person.firstName());
  }

  static List<Item> createList({@required int size}) {
    List<Item> list = [];
    for (var i = 0; i < size; i++) {
      list.add(create());
    }
    return list;
  }
}
