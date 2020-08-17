import 'package:flutter/material.dart';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return postItem();
        },
        itemCount: 4,
      ),
    );
  }
}
