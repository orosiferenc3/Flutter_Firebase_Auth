# Flutter Firebase Authentication

In this project I show you how to make a **Firebase Authentication**. **If you want to use this code you have to make your own Firebase project and you should copy your google-services.json to android/app folder.**

## android/app
You need to copy the google-services.json to android/app folder

## pubspec.yaml
You need these packages in pubspec.yalm

```dart
dependencies:
  flutter:
    sdk: flutter
  firebase_core: "^0.5.2"
  firebase_auth: "^0.18.3"
```

## android/build.gradle
In your android/build.gradle file you need these codes:

```dart
buildscript {
    repositories {
        google() // Google's Maven repository
    }

    dependencies {
        classpath 'com.google.gms:google-services:4.3.4' // Google Services plugin
    }
}
```

```dart
allprojects {
    repositories {
        google() // Google's Maven repository
    }
}
```

## android/app/build.gradle
Your android/app/build.gradle file need to contains the following codes:

```dart
apply plugin: 'com.google.gms.google-services' // Google Services plugin
```

```dart
dependencies {
    implementation platform('com.google.firebase:firebase-bom:26.1.0')
    implementation 'com.google.firebase:firebase-auth'
}
```

## main.dart
In the main.dart file you need this import:

```dart
import 'package:firebase_core/firebase_core.dart';
```

void main should look like this:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

You need to set your homepage as home and you need to make routes which are provides the routes between the pages.

```dart
home: HomePage(),
routes: <String, WidgetBuilder>{
   "/SignInPage": (BuildContext context) => SignInPage(),
   "/SignUpPage": (BuildContext context) => SignUpPage(),
},
```

## homePage.dart
In the homePage.dart file you need this import:

```dart
import 'package:firebase_auth/firebase_auth.dart';
```

You need three variable:

```dart
final FirebaseAuth _auth = FirebaseAuth.instance;
User user;
bool isSignedIn = false;
```

You need a check status method, a get info method and a sign out method.

```dart
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
```

You have to call the async task in the initState()

```dart
@override
void initState() {
  super.initState();
  this.checkSignInStatus();
  this.getInfo();
}
```

If you press the button you will sign out.

```dart
RaisedButton(
  onPressed: () {
    signOut();
  },
  child: Center(
    child: Text('Sign-out'),
  ),
),
```

## signInPage.dart
In the signInPage.dart file you need this import:

```dart
import 'package:firebase_auth/firebase_auth.dart';
```

You need three variable:

```dart
final FirebaseAuth _auth = FirebaseAuth.instance;
final username = TextEditingController();
final password = TextEditingController();
```

You need a check current user method, a sign in method and a tosignup method.

```dart
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
```

```dart
@override
void initState() {
  super.initState();
  this.checkCurrentUser();
}
```

A textfield should look like this. The important thing is the controller.

```dart
TextField(
  controller: username,
  obscureText: false,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: 'E-mail/Username',
  ),
),
```

If you press the button the sign in method will be executed.

```dart
RaisedButton(
  onPressed: () {
    signIn();
  },
  child: Center(
    child: Text('Sign-in'),
  ),
),
```

I use a gesture detector to navigate the user to the sign up page.

```dart
GestureDetector(
  onTap: () {
    toSignUp();
  },
  child: Text(
    "Sign Up!",
    style: TextStyle(color: Colors.blue),
  ),
),
```
