import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  static Future<void> setUserRecords({
    required String dbId,
    required String email,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('dbId', dbId);
    prefs.setString('email', email);
  }

  static Future<String?> getDbID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? userID = prefs.getString('dbId');
    // String res = userID.toString();
    return userID;
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? userID = prefs.getString('email');
    // String res = userID.toString();
    return userID;
  }

  static Future<void> removeDbValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("dbId");
    prefs.remove("email");
  }

  static Future<bool> checkUserExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool checkValue = prefs.containsKey('dbId');
    return checkValue;
  }
}
