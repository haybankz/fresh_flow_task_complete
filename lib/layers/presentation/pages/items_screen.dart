
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/auth_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/item_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/pages/login_screen.dart';
import 'package:fresh_flow_task/layers/presentation/pages/item_detail_screen.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatefulWidget {


  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<ItemsScreen> {

  AuthNotifier _authNotifier;

  @override
  Widget build(BuildContext context) {

    _authNotifier = context.select((AuthNotifier value) => value);

    return Scaffold(
      appBar: AppBar(title: Text('Carts'),
      actions: [
        FlatButton(onPressed: ()async{
          _showLoader(context);
          await _authNotifier.logOut();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
        }, child: Text("Sign out"))
      ],),
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
        separatorBuilder: (_, __) => Divider(color: Colors.grey,),
          itemCount: itemList.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (_, index) => ListTile(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ItemDetailScreen(item: itemList[index])));
            },

            leading: Image.network('${itemList[index].url}',
            width: 60, height: 60,),

            title:  Text('${itemList[index].name}',
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w400)),

            subtitle:  Text('\$${itemList[index].price}',
                style: TextStyle(color: Colors.grey)),

          ));
    }else if (error != null) {
      return Container();
    } else {
      return Container();
    }
  }

  _showLoader(BuildContext context){
    showDialog(context: context,
        builder: (ctx) => Center(
          child: WillPopScope(
              onWillPop: ()async{
                return Future.value(true);
              },
              child: Material(child: Text('Logging out'))),
        ),
        barrierDismissible: false
    );
  }
}