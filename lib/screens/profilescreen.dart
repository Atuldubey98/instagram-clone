import 'package:flutter/material.dart';

import 'package:masterinstagram/services/serviceutils.dart';
import 'package:masterinstagram/services/userprofiledata.dart';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfiledata userProfiledata = new UserProfiledata();
  ServiceUtils serviceUtils = new ServiceUtils();
  @override
  void initState() {
    userProfiledata.getUserdata();
    userProfiledata.stream = userProfiledata.streamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: userProfiledata.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Container(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Stack(children: [
                                CircleAvatar(
                                  radius: 30,
                                  onBackgroundImageError:
                                      (exception, stackTrace) {},
                                  backgroundImage: NetworkImage(
                                      serviceUtils.userprofilePhoto),
                                ),
                                Positioned(
                                  bottom: 2,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data.username,
                                style: buildTextStyleBold(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(snapshot.data.emailid),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "Followers",
                                style: buildTextStyleBold(),
                              ),
                              Text(
                                snapshot.data.followers.toString(),
                                style: buildTextStyleBold(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "Following",
                                style: buildTextStyleBold(),
                              ),
                              Text(
                                snapshot.data.following.toString(),
                                style: buildTextStyleBold(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "Posts",
                                style: buildTextStyleBold(),
                              ),
                              Text(
                                snapshot.data.posts.toString(),
                                style: buildTextStyleBold(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: (context),
                                builder: (context) {
                                  return BottomModalcamera(
                                    isPost: false,
                                  );
                                });
                          },
                          child: buildContainerButton(
                              400, "Edit Your Profile Photo", Colors.blue)),
                      Divider(),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text("Some errror Occured"));
            }
            return Container(
              child: Center(),
            );
          }),
    );
  }

  TextStyle buildTextStyleBold() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  }
}
