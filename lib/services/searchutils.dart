import 'dart:async';

import 'package:dio/dio.dart';
import 'package:masterinstagram/models/user.dart';
import 'package:masterinstagram/services/serviceutils.dart';

class SearchUtils {
  final StreamController streamController = new StreamController.broadcast();
  void dispose() {
    streamController.close();
  }

  Stream stream;

  Future getSearchedUser(String username) async {
    List<User> userList = List<User>();
    Response response;
    Dio dio = new Dio();
    response = await dio.get(
      ServiceUtils.userdetailsbysearch + username,
    );
    print(response.data);
    response.data['data'].forEach((ele) {
      User user = User(
          emailid: ele['emailid'],
          username: ele['username'],
          userid: ele['_id']);
      userList.add(user);
    });
    streamController.add(userList);
  }
}
