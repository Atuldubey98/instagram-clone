import 'package:flutter/material.dart';
import 'package:masterinstagram/screens/mainscreen.dart';
import 'package:masterinstagram/screens/registerscreen.dart';
import 'package:masterinstagram/services/authenticate.dart';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    TextEditingController passwordcontroller = new TextEditingController();
    TextEditingController emailcontroller = new TextEditingController();
    login() {
      if (loginformkey.currentState.validate()) {
        loginMe(emailcontroller.text, passwordcontroller.text).then(
          (value) {
            if (value == false) {
            } else if (value == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            }
          },
        );
      }
    }

    validateemail(String value) {
      if (value.isEmpty) {
        return "Please Enter a valid email id";
      }
    }

    validatepassword(String value) {
      if (value.isEmpty) {
        return "Please Enter a valid password";
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Pistagram",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30),
                ),
              ),
              Form(
                key: loginformkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildContainerFormField(emailcontroller,
                          loginformkey, "email", validateemail),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildContainerFormField(passwordcontroller,
                          loginformkey, "password", validatepassword),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: buildContainerButton(width, "Login", Colors.blue)),
              ),
              Container(
                child: Text(
                  "------------------OR------------------",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont't have an Account ?  ",
                        style: buildTextStyle(Colors.grey),
                      ),
                      Text(
                        "Sign up",
                        style: buildTextStyle(Colors.black),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildTextStyle(Color color) =>
      TextStyle(color: color, fontSize: 20);
}
