import 'package:flutter/material.dart';
import 'package:masterinstagram/screens/loginscreen.dart';
import 'package:masterinstagram/services/authenticate.dart';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> registerformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    TextEditingController passwordcontroller = new TextEditingController();
    TextEditingController emailcontroller = new TextEditingController();
    TextEditingController usernamecontroller = new TextEditingController();
    register() {
      if (registerformkey.currentState.validate()) {
        registerMe(emailcontroller.text, passwordcontroller.text,
                usernamecontroller.text)
            .then((value) {
          if (value == true) {
          } else if (value == false) {
          } else {}
        });
      }
    }

    validatepassword(String value) {
      if (value.isEmpty) {
        return "Please Enter a valid password";
      }
    }

    validateusername(String value) {
      if (value.isEmpty) {
        return "Please Enter a valid username";
      }
    }

    validateemail(String value) {
      if (value.isEmpty) {
        return "Please Enter a valid email id";
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
                key: registerformkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildContainerFormField(emailcontroller,
                          registerformkey, "email", validateemail),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildContainerFormField(passwordcontroller,
                          registerformkey, "password", validatepassword),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildContainerFormField(usernamecontroller,
                          registerformkey, "username", validateusername),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    register();
                  },
                  child: buildContainerButton(width, "Register", Colors.blue),
                ),
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
                      builder: (context) => LoginScreen(),
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
                        "Have an Account ?",
                        style: buildTextStyle(Colors.grey),
                      ),
                      Text(
                        "Login",
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
