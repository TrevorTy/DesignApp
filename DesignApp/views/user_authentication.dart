import 'package:design_by_me/controllers/user_controller.dart';
import 'package:design_by_me/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAuthentication extends StatefulWidget {
  @override
  _UserAuthenticationState createState() => _UserAuthenticationState();
}

class _UserAuthenticationState extends State<UserAuthentication> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _initialized = false;
  @override
  void initState() {
    //This method is called once this widget loads
    //You cannot use Provider in initstate
    //UserController userController = Provider.of<UserController>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialize();

    if (auth.currentUser() == null) {
      return Material(child: Center(child: CircularProgressIndicator()));
    } else {
      return HomeScreen();
    }
  }

  Future initialize() async {
    UserController userController = Provider.of<UserController>(context);

    if (!_initialized) {
      _initialized = true;
      await userController.handleSignIn();
      setState(() {});
    }
  }
}
