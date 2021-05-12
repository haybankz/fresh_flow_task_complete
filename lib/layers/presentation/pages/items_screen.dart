import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/item_notifier.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatefulWidget {


  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<ItemsScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _buildScreen(),
    );
  }

  Widget _buildScreen(){

    final isLoading = context.select((ItemNotifier n) => n.isLoading);
    final itemList = context.select((ItemNotifier n) => n.itemsList);
    final error = context.select((ItemNotifier n) => n.error);



    if(isLoading){
      return CircularProgressIndicator();
    }else if(!isLoading && error != null){
      return Center(child: Text('$error'));
    }else if(!isLoading && itemList != null){
      return ListView.builder(
        itemCount: itemList.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => Row(
            children: [
              Image.network('${itemList[index].url}'),
              SizedBox(width: 6),
              Column(
                children: [
                  Text('${itemList[index].name}'),
                  SizedBox(height: 4),
                  Text('${itemList[index].price}'),


                ],
              ),
            ],
          ));
    }else if (error != null) {
      return Container();
    } else {
      return Container();
    }
  }
}