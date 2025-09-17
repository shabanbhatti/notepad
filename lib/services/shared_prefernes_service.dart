import 'package:shared_preferences/shared_preferences.dart';

class SpService {
  
static const String isGridKEY= 'isgrid';

static Future<void> setBool(String key, bool value)async{
var sp= await SharedPreferences.getInstance();
await sp.setBool(key, value);
}

static Future<bool?> getBool(String key)async{
var sp= await SharedPreferences.getInstance();
return sp.getBool(key);
}


}