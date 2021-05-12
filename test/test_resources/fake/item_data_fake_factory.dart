
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';

class ItemModelFakeFactory {
  static ItemModel create({

    String name,
    String url,
    String price
  }) {
    return ItemModel(
        price: price ?? faker.randomGenerator.integer(10).toString(),
        name: name ?? faker.person.firstName(),
       url: url ?? faker.lorem.word());
  }

  static List<ItemModel> createList({@required int size}) {
    List<ItemModel> list = [];
    for (var i = 0; i < size; i++) {
      list.add(create());
    }
    return list;
  }
}
