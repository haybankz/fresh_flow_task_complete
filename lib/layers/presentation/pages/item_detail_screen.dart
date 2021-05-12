import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/data/models/item_model.dart';

class ItemDetailScreen extends StatelessWidget {

  final ItemModel item;

  ItemDetailScreen({@required this.item}) :assert(item != null);
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(item.name ?? ''),),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(item.url, height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 6,
              ),
              RichText(text: TextSpan(text: 'Name: ',
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(text: item.name, style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w400),)
              ])),
              SizedBox(
                height: 6,
              ),
              RichText(text: TextSpan(text: 'Price: ',
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(text: "\$${item.price}", style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w400),)
                  ])),

            ],
          ),
        ),
      );
    }
}