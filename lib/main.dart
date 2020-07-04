import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/darktheme.dart';
import 'package:shoppinglist/listModel.dart';
import 'package:shoppinglist/mainview.dart';
import 'package:shoppinglist/styles.dart';
import 'package:shoppinglist/summarize.dart';
import 'databaseOperations.dart';

void main() => runApp(ShoppingList());



class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();



}

DarkThemeProvider themeChangeProvider=new DarkThemeProvider();
SummarizePrefProv summarizePrefProv=new SummarizePrefProv();
class _ShoppingListState extends State<ShoppingList> {
  DarkThemeProvider themeProvider=new DarkThemeProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentAppTheme();
  }
  @override
  Widget build(BuildContext context) {
    
    DatabaseOperations.createDatabase();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkThemeProvider>(create: (_)=>themeChangeProvider),
        ChangeNotifierProvider<ListModel>(create: (context) => ListModel())
    ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: Scaffold(
              body: MainView(),
            ),
          );
        },
      ),
    ); 
      
      
      
  }

  void getCurrentAppTheme() async{
    themeChangeProvider.darkTheme=await themeChangeProvider.darkThemePrefs.getTheme();
  }
}
