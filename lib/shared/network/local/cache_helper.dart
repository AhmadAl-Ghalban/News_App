import 'package:shared_preferences/shared_preferences.dart';

class CacheHelpper{
static SharedPreferences? sharedPreferences;

static init ()async {
  //تعريف هون 
  sharedPreferences= await SharedPreferences.getInstance();
}
static  Future<bool> putBoolean({required String key,required bool value})async{

 return await sharedPreferences!.setBool(key, value);
}
static bool? getBoolean({required String key}){

 return  sharedPreferences!.getBool(key);
}

}