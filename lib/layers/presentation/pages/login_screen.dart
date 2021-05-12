import 'package:flutter/cupertino.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  AuthNotifier _authNotifier;
  ItemNotifier _itemNotifier;


  @override
  Widget build(BuildContext context) {
    _authNotifier = context.select((AuthNotifier value) => value);
    _itemNotifier = context.select((ItemNotifier value) => value);
    return Scaffold(
      key: _scaffoldKey,
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
            RaisedButton(onPressed: () async{
              if (_formKey.currentState.validate()) {
                _showLoader(context);

                await _authNotifier.loginUser(_emailController.text.trim(),
                    _passwordController.text.trim());

                Navigator.pop(context);

                final userEmail = _authNotifier.userEmail;
                final error = _authNotifier.error;
                if (userEmail != null) {
                  _itemNotifier.fetchAllItems();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => ItemsScreen()), (route) => false);
                } else {
                  _scaffoldKey.currentState.showSnackBar(
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
    showCupertinoDialog(context: context,
        builder: (ctx) => Center(
          child: WillPopScope(
              onWillPop: ()async{
                return Future.value(true);
              },
              child: Material(child: Text('Loading....'))),
        ),
        barrierDismissible: false
    );
  }
}
