import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:masterinstagram/models/user.dart';
import 'package:masterinstagram/models/userstatics.dart';
import 'package:masterinstagram/services/serviceutils.dart';

class UserProfiledata {
  StreamController<User> streamController =
      new StreamController<User>.broadcast();
  StreamController<double> postProgressstreamController =
      new StreamController<double>.broadcast();
  void dispose() {
    streamController.close();
    postProgressstreamController.close();
  }

  Stream<double> postProgressStream;
  Stream<User> stream;
  Future getUserdata() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(ServiceUtils.userdetails);
    print(response.data);
    final User user = User(
      emailid: UserStatic.emailid,
      followers: response.data['data']['followers'],
      following: response.data['data']['following'],
      posts: response.data['data']['posts'],
      userid: UserStatic.id,
      username: response.data['data']['username'],
    );
    streamController.add(user);
  }

  Future<String> updateProfilePicture(File image) async {
    Dio dio = new Dio();
    Response response;
    String filename = image.path.split("/").last.toString();
    FormData formData = new FormData.fromMap({
      UserStatic.id:
          await MultipartFile.fromFile(image.path, filename: filename)
    });
    response = await dio.post(ServiceUtils.userprofilephotoupdate,
        data: formData, onReceiveProgress: (sent, rec) {
      postProgressstreamController.add((sent / rec) * 100);
    });
    print(response.data);
    if (response.data['data'] == 1) {
      return "ok";
    }
    return "notok";
  }
}
