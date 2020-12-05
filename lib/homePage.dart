import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isSignedIn = false;
  BuildContext context;

  checkSignInStatus() async {
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SignInPage");
      }
    });
  }

  getInfo() async {
    _auth.authStateChanges().listen((User user) {
      if (this.user != null) {
        setState(() {
          this.user = user;
          this.isSignedIn = true;
        });
      }
    });
  }

  signOut() {
    _auth.signOut();
    print('SignOut: Sign out was successful.');
  }

  @override
  void initState() {
    super.initState();
    this.checkSignInStatus();
    this.getInfo();
  }

  @override
  Widget build(context) {
    setState(() => this.context = context);
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HomePage'),
              RaisedButton(
                onPressed: () {
                  signOut();
                },
                child: Center(
                  child: Text('Sign-out'),
                ),
              ),
            ]),
      ),
    );
  }
}
