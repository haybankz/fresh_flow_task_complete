import 'package:flutter/foundation.dart';

import '../../domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    @required name,
    @required price,
    @required url
  }) : super(
    name: name,
    price: price,
    url: url

  );

  static ItemModel fromJson(Map<String, dynamic> json) => ItemModel(

      name: json['name'],
      price: json['price'],
      url: json['url']

  );

  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'price': price,
      'url': url
    };
  }
}
