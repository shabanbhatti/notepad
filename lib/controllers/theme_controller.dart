import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeData currentTheme = lightTheme;

  ThemeData get myTheme {
    return currentTheme;
  }


  Future<void> getTheme()async{

var sp =await SharedPreferences.getInstance();

var isThemeFetched= sp.getString('theme')??'light';

currentTheme= isThemeFetched=='light'?lightTheme:darkTheme;

notifyListeners();

  }

  Future<void> toggled() async{

var sp =await SharedPreferences.getInstance();

    if (currentTheme == lightTheme) {
      currentTheme = darkTheme;
      sp.setString('theme', 'dark');
    } else {
      currentTheme = lightTheme;
      sp.setString('theme', 'light');
    }
    notifyListeners();
  }
}
