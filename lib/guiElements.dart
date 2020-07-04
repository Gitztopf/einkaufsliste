import 'package:flutter/material.dart';

import 'Item.dart';
import 'databaseOperations.dart';

abstract class GUIElements extends StatefulWidget {
  static addElement(int count) {
    String itemName = "";
    TextEditingController textEditingController = new TextEditingController();
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 175,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Icon(
                              Icons.label,
                              color: Colors.white24,
                            ),
                            flex: 1),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Bezeichnung",
                              filled: true,
                            ),
                            controller: textEditingController,
                            onSubmitted: (value) {
                              itemName = textEditingController.text;
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
                                TextStyle(color: Colors.white54, fontSize: 20),
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
                                TextStyle(fontSize: 20, color: Colors.white54),
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
                          itemName = textEditingController.text;
                          setState(() {
                            DatabaseOperations.addEntryToDatabase(
                                Item(null, itemName, count));
                          });
                          Navigator.pop(context);
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
  }

  static popUpItems(context) {
    Color c = Theme.of(context).backgroundColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;

    return [
      PopupMenuItem(
        value: "sort_list",
        child: Row(
          children: <Widget>[
            Icon(
              Icons.sort,
              color: c,
            ),
            Text(
              " Liste Sortieren",
              style: TextStyle(color: c),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: "clear_all",
        child: Row(
          children: <Widget>[
            Icon(
              Icons.clear_all,
              color: c,
            ),
            Text(" Alle Elemente löschen", style: TextStyle(color: c))
          ],
        ),
      ),
      PopupMenuItem(
        value: "settings",
        child: Row(
          children: <Widget>[
            Icon(Icons.settings, color: c),
            Text(" Einstellungen", style: TextStyle(color: c))
          ],
        ),
      ),
    ];
  }
}
