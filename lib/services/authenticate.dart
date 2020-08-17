import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:masterinstagram/models/userstatics.dart';

import 'package:masterinstagram/services/serviceutils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future authenticateMe() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("emailid") == null || prefs.getString("id") == null) {
    return false;
  }
  UserStatic.emailid = prefs.getString("emailid");
  UserStatic.id = prefs.getString("id");
  return true;
}

Future loginMe(String emailid, String password) async {
  final user = {"emailid": emailid, "password": password};
  try {
    Dio dio = new Dio();
    Response response;
    response = await dio.post(
      ServiceUtils.login,
      data: json.encode(user),
    );

    if (response.statusCode > 200) {
      return "down";
    }

    if (response.data['error'] == 1) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("emailid", response.data['emailid']);
    prefs.setString("id", response.data['data']);
    UserStatic.emailid = response.data['emailid'];
    UserStatic.id = response.data['id'];
    return true;
  } catch (e) {
    return e;
  }
}

Future registerMe(String emailid, String password, String username) async {
  final Map<String, String> user = {
    "emailid": emailid,
    "password": password,
    "username": username
  };
  try {
    Dio dio = new Dio();
    Response response;
    response = await dio.post(
      ServiceUtils.register,
      data: json.encode(user),
    );
    if (response.statusCode > 200) {
      return "down";
    }

    if (response.data['error'] == 1) {
      return false;
    }
    return true;
  } catch (e) {
    return e;
  }
}
