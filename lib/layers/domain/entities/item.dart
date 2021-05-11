import 'package:equatable/equatable.dart';

class Item extends Equatable {

  final String name;
  final String price;
  final String url;

  Item({this.name, this.price, this.url});


  @override
  // TODO: implement props
  List<Object> get props => [name, price, url];

}