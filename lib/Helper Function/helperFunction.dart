import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
    
Future<void> setPageName(String pageName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("pageName", pageName);
  }

  Future<String> getPageName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("pageName")?? "page";
  }
}
