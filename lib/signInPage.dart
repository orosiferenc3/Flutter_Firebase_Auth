import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final username = TextEditingController();
  final password = TextEditingController();
  BuildContext context;

  checkCurrentUser() async {
    _auth.authStateChanges().listen((User user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  void signIn() async {
    try {
      if (username.text != "" && password.text != "") {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: username.text, password: password.text);
        print('SignIn: Sign in was successful.');
        print(userCredential);
      } else {
        print('SignIn: Username or password is missing.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('SignIn: No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('SignIn: Wrong password provided for that user.');
      }
    }
  }

  toSignUp() async {
    Navigator.pushReplacementNamed(context, "/SignUpPage");
  }

  @override
  void initState() {
    super.initState();
    this.checkCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(context) {
    setState(() => this.context = context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: username,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail/Username',
                ),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  signIn();
                },
                child: Center(
                  child: Text('Sign-in'),
                ),
              ),
              Text("Do you have an account? If you don't, please sign up!"),
              GestureDetector(
                onTap: () {
                  toSignUp();
                },
                child: Text(
                  "Sign Up!",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
