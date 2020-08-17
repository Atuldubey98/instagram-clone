import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterinstagram/models/userstatics.dart';
import 'package:masterinstagram/screens/postiingScreen.dart';
import 'package:masterinstagram/services/serviceutils.dart';

AppBar builAppbar(String data, bool isCenter, BuildContext context,
    List<Widget> listItem, Widget leading) {
  return AppBar(
    actions: listItem,
    textTheme: Theme.of(context).textTheme,
    title: Text(
      data,
      style: TextStyle(color: Colors.black),
    ),
    centerTitle: isCenter,
    elevation: 5,
    backgroundColor: Colors.white,
    leading: leading,
  );
}

Container buildContainerFormField(TextEditingController controller,
    GlobalKey<FormState> key, String data, Function validateme) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.grey[300],
    ),
    child: TextFormField(
      validator: validateme,
      controller: controller,
      cursorRadius: Radius.circular(5),
      style: TextStyle(color: Colors.black, fontSize: 20),
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: data,
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

Container buildContainerButton(double width, String data, Color color) {
  return Container(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    alignment: Alignment.center,
    height: 40,
    width: width * 0.6,
    child: Text(
      data,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)), color: color),
  );
}

class BottomModalcamera extends StatelessWidget {
  final bool isPost;

  const BottomModalcamera({Key key, this.isPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    Future getImage(bool isCamera) async {
      File image;
      final galleryImage = await picker.getImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (galleryImage != null) {
        image = File(galleryImage.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostSceen(
              image: image,
              isPost: isPost,
            ),
          ),
        );
      }
    }

    return Container(
      height: 200,
      child: ListView(
        children: [
          Container(
              color: Colors.grey[400],
              padding: EdgeInsets.only(top: 10, bottom: 20),
              alignment: Alignment.center,
              child: Text(
                "Source",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          GestureDetector(
            onTap: () {
              getImage(false);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Gallery",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              getImage(true);
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Camera",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget postItem() {
  ServiceUtils serviceUtils = new ServiceUtils();
  return Container(
    child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 15,
          ),
          title: Text(UserStatic.emailid),
          trailing: Icon(Icons.arrow_downward),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: ClipRRect(
            child: Image.network(serviceUtils.userprofilePhoto),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.comment,
                    color: Colors.black,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 30,
                  )
                ],
              ),
            ),
            Container(
                child: Icon(Icons.save_alt),
                padding: EdgeInsets.only(right: 20))
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                "View all Comments",
                style: TextStyle(color: Colors.grey),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        )
      ],
    ),
  );
}
