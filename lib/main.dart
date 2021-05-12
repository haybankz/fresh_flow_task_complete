import 'package:flutter/material.dart';
import 'package:fresh_flow_task/commons/utils.dart';
import 'package:fresh_flow_task/injection_container.dart' as di;
import 'package:fresh_flow_task/layers/presentation/notifiers/auth_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/item_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/pages/items_screen.dart';
import 'package:fresh_flow_task/layers/presentation/pages/login_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthNotifier>(
          create: (_) => di.sl<AuthNotifier>(),
        ),

        ChangeNotifierProvider<ItemNotifier>(
          create: (_) => di.sl<ItemNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'FreshFlow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<SplashScreen> {

  AuthNotifier _authNotifier;
  ItemNotifier _itemNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), (){

      if(_authNotifier.isUserLoggedIn()){

        Utils.sendEvent("page view");

        _itemNotifier.fetchAllItems();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => ItemsScreen()),
                (route) => false);
      }else{
        Utils.sendEvent("login");
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    _authNotifier = context.select((AuthNotifier value) => value);
    _itemNotifier = context.select((ItemNotifier value) => value);

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

