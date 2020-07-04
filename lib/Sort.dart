import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Item.dart';

class Sort {
  static Widget sortDropListItem(String sortName) {
    Icon i;
    String sortDesc;
    switch (sortName) {
      case "a_to_z":
        sortDesc = "Alphabetisch";
        i = Icon(Icons.sort_by_alpha);
        break;
      case "least_to_most":
        i = Icon(Icons.trending_up);
        sortDesc = "Anzahl(Aufsteigend)";
        break;
      case "most_to_least":
        sortDesc = "Anzahl(Absteigend)";
        i = Icon(Icons.trending_down);
        break;
      case "newest_first":
        i = Icon(Icons.filter_1);
        sortDesc = "Neueste zuerst";
        break;
      case "latest_first":
        i = Icon(Icons.filter_9);
        sortDesc = "Älteste zuerst";
        break;
      default:
        i = Icon(Icons.filter_9);
        sortDesc = "Älteste zuerst";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: <Widget>[
        i,
        Text(
          " " + sortDesc,
          style: TextStyle(fontSize: 16),
        )
      ]),
    );
  }

  static dropDownListItems(){
    return [
      DropdownMenuItem(

          value: "a_to_z",
          child: Sort.sortDropListItem("a_to_z")
      ),
      DropdownMenuItem(
        value: "least_to_most",
        child: Sort.sortDropListItem("least_to_most"),
      ),
      DropdownMenuItem(
        value: "most_to_least",
        child: Sort.sortDropListItem("most_to_least"),
      ),
      DropdownMenuItem(
        value: "newest_first",
        child: Sort.sortDropListItem("newest_first"),
      ),
      DropdownMenuItem(
        value: "oldest_first",
        child: Sort.sortDropListItem("oldest_first"),
      )
    ];
  }

  static sortList(List<Item> liste, String sortString){
    switch (sortString) {
      case "a_to_z":


          liste.sort((a, b) => a.name
              .toLowerCase()
              .compareTo(
              b.name.toLowerCase()));

        break;
      case "least_to_most":


          liste.sort((a, b) => a.quantity
              .compareTo(b.quantity));


        break;
      case "most_to_least":


          liste.sort((b, a) => a.quantity
              .compareTo(b.quantity));


        break;
      case "newest_first":


          liste.sort((b, a) => a
              .databaseID
              .compareTo(b.databaseID));


        break;
      case "oldest_first":


          liste.sort((a, b) => a
              .databaseID
              .compareTo(b.databaseID));

        break;
    }
    return liste;
  }

  static setSortMethod(String value) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString("sortMethod", value);
  }

  static getSortMethod() async{
    String sortString;
    SharedPreferences prefs= await SharedPreferences.getInstance();
    sortString=prefs.getString("sortMethod");
    return sortString;
}

}
