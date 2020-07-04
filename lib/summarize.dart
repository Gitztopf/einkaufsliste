import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String SUMMARIZE="summarize";

class SummarizePrefs{
  Future<void> setSumBool(bool value) async {
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setBool(SUMMARIZE, value);
  }

  getSumBool()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    return sharedPreferences.getBool(SUMMARIZE);
  }
}


class SummarizePrefProv with ChangeNotifier{
  SummarizePrefs sP=SummarizePrefs();
  bool _summarize=false;
  bool get summarize=>_summarize;

  set summarize(bool value){
    _summarize=value;
    sP.setSumBool(value);
    notifyListeners();
  }
}