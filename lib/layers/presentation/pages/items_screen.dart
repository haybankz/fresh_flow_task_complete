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
    // ItemNotifier provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Carts"),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen(){

    final isLoading = context.select((ItemNotifier n) => n.isLoading);
    final itemList = context.select((ItemNotifier n) => n.itemsList);
    final error = context.select((ItemNotifier n) => n.error);



    if(isLoading){
      return Center(child: CircularProgressIndicator());
    }else if(!isLoading && error != null){
      return Center(child: Text('$error'));
    }else if(!isLoading && itemList != null){
      return ListView.separated(
        separatorBuilder: (ctx, index) => Divider(color: Colors.grey,),
        itemCount: itemList.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => ListTile(
            title: Text(itemList[index].name ?? ''),
            subtitle: Text(itemList[index].price),
            leading: Image.network('${itemList[index].url}', height: 60, width: 60,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

          ));
    }else if (error != null) {
      return Container();
    } else {
      return Container();
    }
  }
}