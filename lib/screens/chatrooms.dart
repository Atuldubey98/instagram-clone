import 'package:flutter/material.dart';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builAppbar(
          "Chats",
          false,
          context,
          [],
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back, color: Colors.black),
              ))),
    );
  }
}
