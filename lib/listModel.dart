


import 'package:flutter/material.dart';
import 'package:shoppinglist/Item.dart';
import 'package:shoppinglist/databaseOperations.dart';

class ListModel extends ChangeNotifier{
  List<Item> _items=[];
  get items =>_items;

  set items(List<Item> list){
    assert (list !=null);
    assert (_items.every((element) => element!=null));
    _items=list;

    notifyListeners();
  }

  add(Item item){
    DatabaseOperations.addEntryToDatabase(item);
    _items.add(item);
    notifyListeners();
  }
  removeAt(int index){
    DatabaseOperations.removeItemFromDatabase(_items[index].name);
    _items.removeAt(index);
    notifyListeners();
  }
  removeAll(){
    for(Item i in _items){
      DatabaseOperations.removeItemFromDatabase(i.name);
    }
    _items.clear();
  }
  length(){
    return _items.length;
  }


  @override
  String toString() {
    // TODO: implement toString
    for(Item i in _items){
      print("Model:"+i.toString());
    }
  }

}