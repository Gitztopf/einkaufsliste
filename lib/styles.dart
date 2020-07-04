
import 'package:flutter/material.dart';


class Styles{
   static ThemeData themeData(bool isDarkTheme,context){
   return ThemeData(
       primarySwatch: Colors.green,
       brightness: isDarkTheme?Brightness.dark: Brightness.light,
       textSelectionHandleColor: Colors.green.shade900,
       accentColor: Colors.green,
       cursorColor: Colors.green

   );


  }


}