import 'package:flutter/material.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/auth_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/notifiers/item_notifier.dart';
import 'package:fresh_flow_task/layers/presentation/pages/items_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  AuthNotifier auth;
  ItemNotifier _itemNotifier;


  @override
  Widget build(BuildContext context) {
    auth = context.select((AuthNotifier value) => value);
    _itemNotifier = context.select((ItemNotifier value) => value);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email"
              ),
              validator: (value) {
                if (value.isNotEmpty) return null;
                return "Enter Email";
              },
            ),

            const SizedBox(height: 20,),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password"
              ),
              validator: (value) {
                if (value.isNotEmpty) return null;
                return "Enter password";
              },
            ),

            const SizedBox(height: 20,),
            RaisedButton(onPressed: () {
              if (_formKey.currentState.validate()) {
                _showLoader(context);

                auth.loginUser(_emailController.text.trim(),
                    _passwordController.text.trim());

                Navigator.pop(context);

                final userEmail = auth.userEmail;
                print(userEmail);
                final error = auth.error;
                if (userEmail != null) {
                  _itemNotifier.fetchAllItems();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ItemsScreen()));
                } else {
                  scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text("$error")));
                }
              }
            },
              child: Text("Sign in"),)
          ],
        ),
      ),
    );
  }

  _showLoader(BuildContext context){
    showDialog(context: context,
        builder: (ctx) => WillPopScope(
            onWillPop: ()async{
              return Future.value(true);
            },
            child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator())),
        barrierDismissible: false
    );
  }
}
