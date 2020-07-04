import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DarkThemePrefs{
  static const THEME_DARK="THEMESTATUS";

  setDarkTheme(value)async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool(THEME_DARK, value);
  }
  getTheme()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getBool(THEME_DARK)??false;
  }
}

class DarkThemeProvider with ChangeNotifier{
  DarkThemePrefs darkThemePrefs=DarkThemePrefs();
  bool _darkTheme=false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value){
    print('yeet');
    _darkTheme=value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}


