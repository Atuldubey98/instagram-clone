import 'package:flutter/material.dart';
import 'package:masterinstagram/screens/postsScreen.dart';
import 'package:masterinstagram/services/serviceutils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServiceUtils serviceUtils = new ServiceUtils();

  @override
  Widget build(BuildContext context) {
    double height2 = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Container(
              height: height2 * 0.16,
              padding: EdgeInsets.only(top: 5, left: 5),
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: height2 * 0.045,
                                backgroundImage:
                                    NetworkImage(serviceUtils.userprofilePhoto),
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                            Text(
                              "Your Story",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        Flexible(
                          flex: 3,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CircleAvatar(
                                    radius: height2 * 0.045,
                                  ),
                                ),
                                Text(
                                  "Your Story",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                            itemCount: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            PostScreen()
          ],
        ),
      ),
    );
  }
}
