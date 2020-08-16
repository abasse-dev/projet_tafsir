import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setSharedPreferences(String key) async {
  var pref = await SharedPreferences.getInstance();
   return pref.setInt(key, 1);
  
}

Future<bool> getSharedPreferences(String key) async {
  var pref = await SharedPreferences.getInstance();
   return pref.containsKey(key);
}