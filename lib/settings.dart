import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppinglist/darktheme.dart';
import 'package:shoppinglist/databaseOperations.dart';
import 'package:shoppinglist/summarize.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool sum=true;
  bool sumex=true;
  @override
  Future<void> initState(){
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final themeChange = Provider.of<DarkThemeProvider>(context);
    final summarize = Provider.of<SummarizePrefProv>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Dark Mode:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: themeChange.darkTheme,
                    onChanged: (value) {
                      themeChange.darkTheme = value;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
