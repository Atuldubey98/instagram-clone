import 'package:flutter/material.dart';
import 'package:masterinstagram/screens/loginscreen.dart';
import 'package:masterinstagram/screens/mainscreen.dart';
import 'package:masterinstagram/services/authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PistaGram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            textTheme: TextTheme(headline1: TextStyle(color: Colors.black))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.data == false) {
            return LoginScreen();
          }
          return MainScreen();
        },
        future: authenticateMe(),
      ),
    );
  }
}
