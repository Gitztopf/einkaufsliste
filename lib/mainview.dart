import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shoppinglist/databaseOperations.dart';
import 'package:shoppinglist/guiElements.dart';
import 'package:shoppinglist/listModel.dart';
import 'package:shoppinglist/settings.dart';
import 'package:sqflite/sqflite.dart';
import 'Sort.dart';
import 'Item.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  bool listready = false;
  String selectedValue;

  @override
  void initState() {
    DatabaseOperations.loadDataFromDatabase().then((value) async {
      selectedValue= await Sort.getSortMethod()??"oldest_first";
        for(Item i in value){
          print(i.toString());
      }
        ListModel().items = [];
        ListModel().items=value;
        for (Item i in ListModel().items) {
          print(i.toString());
        }
        ListModel().items=Sort.sortList(ListModel().items, selectedValue);
        listready = true;
      ListModel().toString();
      print(ListModel().length().toString());
    });

  }
  String itemName = "";
  TextEditingController textEditingController=new TextEditingController(

  );

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ListModel>(context);
     final addFormKey= GlobalKey<FormState>() ;

    return Consumer<ListModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Einkaufsliste"),
            actions: <Widget>[
              PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == "sort_list") {
                      print('Sort');

                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Liste Sortieren: ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          DropdownButton(
                                            value: selectedValue,
                                            items: Sort.dropDownListItems(),
                                            onChanged: (dropValue) {
                                              setState(() {
                                                selectedValue = dropValue;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ).then((value) {
                        Sort.setSortMethod(selectedValue);
                        initState();
                      });
                    } else if (value == "clear_all") {
                      ListModel().removeAll();
                    }
                    else if(value=="settings"){
                      print('Settings');
                      Navigator.push(context,MaterialPageRoute(
                        builder:(context) => Settings(),

                      ));

                    }
                  },
                  itemBuilder: (context) => GUIElements.popUpItems(context))
            ],
          ),
          floatingActionButton: FloatingActionButton(

            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.add),
            onPressed: () {

              int count = 5;
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding:
                        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: addFormKey,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Icon(
                                            Icons.label,
                                            color: Theme.of(context).backgroundColor.computeLuminance()>0.5?Colors.black45:Colors.white54,
                                          ),
                                          flex: 1),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Bezeichnung",
                                            filled: true,
                                          ),
                                          controller: textEditingController,

                                          validator: (value) {
                                            if(value.isEmpty){
                                              return "Bezeichnung eingeben";
                                            }
                                            return null;
                                          },
                                        ),
                                        flex: 8,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Anzahl: ",
                                          style:
                                          TextStyle(color: Theme.of(context).backgroundColor.computeLuminance()>0.5?Colors.black45:Colors.white54, fontSize: 20),
                                        ),
                                        flex: 3,
                                      ),
                                      Expanded(
                                        flex: 13,
                                        child: Slider(
                                          value: count.toDouble(),
                                          divisions: 50,
                                          min: 1,
                                          max: 50,
                                          onChangeStart: (value) =>
                                          (print('Auswahl bei $value gestartet')),
                                          onChangeEnd: (value) =>
                                          (print('Auswahl bei $value beendet')),
                                          onChanged: (value) {
                                            setState(() {
                                              count = value.floor();
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "$count",
                                          style:
                                          TextStyle(fontSize: 20, color: Theme.of(context).backgroundColor.computeLuminance()>0.5?Colors.black45:Colors.white54),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.add),
                                          Text("Hinzufügen")
                                        ],
                                      ),
                                      onPressed: () {
                                        if(addFormKey.currentState.validate()){

                                          itemName=textEditingController.text;
                                          textEditingController.clear();
                                          setState(() {
                                            ListModel().add(Item(null,itemName,count));
                                          });

                                          Navigator.pop(context);
                                        };

                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).then((value) {
                setState(() {
                  initState();
                });
              });
            },
          ),
          body: listready == true
              ? Container(
              child: ListView.separated(
                  itemBuilder: ((BuildContext context, int index) =>
                  (listItem(index, context))),
                  separatorBuilder: (context, index) => (Divider(
                    color: Colors.grey,
                    thickness: .25,
                    height: 1,
                  )),
                  itemCount: ListModel().length()))
              : Center(
            child: CircularProgressIndicator(),
          )
        );

      },

    );
  }

  Widget listItem(int i, BuildContext context) {
    print(ListModel().items[i].toString());

    return Dismissible(
      secondaryBackground: Container(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.check),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
          ListModel().removeAt(i);
      },
      key: UniqueKey(),
      background: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.check),
            )
          ],
        ),
        color: Colors.green,
      ),
      child: Container(
        child: ListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  ListModel().items[i].quantity.toString(),
                  textAlign: TextAlign.end,
                ),
                flex: 1,
              ),
              Expanded(
                child: Icon(Icons.close),
                flex: 1,
              ),
              Expanded(
                child: Text(ListModel().items[i].name.name),
                flex: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
