import 'dart:io';

import 'package:flutter/material.dart';

import 'package:masterinstagram/services/userprofiledata.dart';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';

class PostSceen extends StatefulWidget {
  final File image;
  final bool isPost;
  const PostSceen({Key key, this.image, this.isPost}) : super(key: key);
  @override
  _PostSceenState createState() => _PostSceenState();
}

class _PostSceenState extends State<PostSceen> {
  UserProfiledata userProfiledata = new UserProfiledata();
  checkpost() {
    if (widget.isPost) {
      return "done";
    }
    userProfiledata.updateProfilePicture(widget.image).then((value) {
      if (value == "ok") {
        Navigator.pop(
          context,
        );
      }
    });
  }

  @override
  void initState() {
    userProfiledata.postProgressStream =
        userProfiledata.postProgressstreamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builAppbar("Change Profile Photo", true, context, [], null),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: widget.image == null
                ? Text("Choose an image")
                : ClipRRect(
                    child: Image.file(widget.image),
                    borderRadius: BorderRadius.circular(8),
                  ),
          ),
          StreamBuilder<double>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "****" + snapshot.data.toString() + "****",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                );
              }
              return Container();
            },
            stream: userProfiledata.postProgressStream,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        tooltip: "Update the profile photo",
        onPressed: () {
          checkpost();
        },
        child: Icon(Icons.photo_size_select_actual),
      ),
    );
  }
}
