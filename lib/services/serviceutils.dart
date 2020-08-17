import 'package:masterinstagram/models/userstatics.dart';

class ServiceUtils {
  static String url = "http://192.168.0.110:";
  static String port = "8000";
  static String login = url + port + "/login";
  static String register = url + port + "/register";
  static String userdetails = url + port + "/userdetails/" + UserStatic.id;
  final String userprofilePhoto =
      url + port + "/userdetails" + "/getprofilephoto/" + UserStatic.id;
  static Map<String, String> jsonHeader = {"Content-Type": "application/json"};
  static String userprofilephotoupdate =
      register + "/" + "registerDP/" + UserStatic.id;
  static String userdetailsbysearch =
      url + port + "/userdetails/" + "getuserdetails/";
}
