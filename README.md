# Flutter Firebase Authentication

In this project I show you how to make a Firebase Authentication. If you want to use this code you have to make your own Firebase project and you should copy your google-services.json to android/app folder.

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
In the main.dart file you need these imports:

import 'package:firebase_core/firebase_core.dart';
void main should look like this:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```
