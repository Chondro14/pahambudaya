import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/screen/splash_screen_main_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return SplashScreenMainView();
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
