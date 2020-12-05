import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final username = TextEditingController();
  final password = TextEditingController();
  BuildContext context;

  checkAuthentication() async {
    _auth.authStateChanges().listen((User user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  toSignIn() async {
    Navigator.pushReplacementNamed(context, "/SignInPage");
  }

  void signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: username.text, password: password.text);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'E-mail',
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
                  signUp();
                },
                child: Center(
                  child: Text('Sign-Up'),
                ),
              ),
              Text("I have an account! Go back and sign in!"),
              GestureDetector(
                onTap: () {
                  toSignIn();
                },
                child: Text(
                  "Sign In!",
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
