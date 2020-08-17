import 'dart:async';
import 'package:masterinstagram/simplewidgets/simplewidgets.dart';
import 'package:flutter/material.dart';
import 'package:masterinstagram/models/userstatics.dart';
import 'package:masterinstagram/screens/chatrooms.dart';
import 'package:masterinstagram/screens/homescreen.dart';
import 'package:masterinstagram/screens/profilescreen.dart';
import 'package:masterinstagram/screens/searchscreen.dart';
import 'package:masterinstagram/services/socketconnection.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  bool isConnected;
  final StreamController _streamController = new StreamController.broadcast();
  Stream stream;
  SocketConnectionItem socketConnectionItem = new SocketConnectionItem();
  List<Widget> _widget = [
    HomeScreen(),
    SearchScreen(),
    Container(),
    ProfileScreen()
  ];

  Widget leading() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: (context),
            builder: (context) {
              return BottomModalcamera(
                isPost: true,
              );
            });
      },
      child: Icon(
        Icons.camera_alt,
        color: Colors.black,
      ),
    );
  }

  tapped(int tappedindex) {
    setState(() {
      index = tappedindex;
    });
  }

  @override
  void initState() {
    isConnected = false;
    stream = _streamController.stream;
    socketConnectionItem.getSocketConnectionItem();

    socketConnectionItem.socket.on("connect", (data) {
      isConnected = true;

      _streamController.add(true);
    });
    socketConnectionItem.socket.on("connecting", (data) {
      _streamController.add("c");
    });
    socketConnectionItem.socket.on("disconnect", (data) {
      _streamController.add(false);
    });
    socketConnectionItem.socket.on("reconnecting", (data) {
      _streamController.add("c");
    });
    socketConnectionItem.socket.on("reconnect", (data) {
      _streamController.add("c");
    });

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          currentIndex: index,
          unselectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
          onTap: tapped,
          items: [
            BottomNavigationBarItem(
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Search",
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.search,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Notification",
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.notifications,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
        appBar: AppBar(
          actions: [
            index == 3
                ? Container()
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoomsScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  stream: stream,
                  initialData: isConnected ? true : false,
                  builder: (context, snapshot) {
                    if (snapshot.data == "c") {
                      return Container(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.data == true) {
                      return Icon(
                        Icons.check,
                        color: Colors.green,
                      );
                    } else if (snapshot.data == false) {
                      return Icon(Icons.highlight_off, color: Colors.red);
                    }
                    return Icon(Icons.check, color: Colors.green);
                  }),
            )
          ],
          textTheme: Theme.of(context).textTheme,
          title: Text(
            index == 3 ? UserStatic.emailid : "Pistagram",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 5,
          backgroundColor: Colors.white,
          leading: index == 3 ? null : leading(),
        ),
        body: _widget[index]);
  }
}
