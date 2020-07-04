import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppinglist/summarize.dart';
import 'package:sqflite/sqflite.dart';
import 'globals.dart' as globals;
import 'Item.dart';

class DatabaseOperations {
  static void createDatabase() async {
    String dbPath = join(await getDatabasesPath(), 'item.db');
    print("onCreate:" + dbPath);
    final db = openDatabase(dbPath, onCreate: (database, version) {
      database.execute(
          "CREATE TABLE Item(id INTEGER PRIMARY KEY AUTOINCREMENT,itemname TEXT, quantity INTEGER)");
      database.insert("Item", {"itemname": "Fisch", "Quantity": 4});
      database.insert("Item", {"itemname": "Hamburger", "Quantity": 2});
      database.insert("Item", {"itemname": "Cheeseburger", "Quantity": 1});
      database.insert("Item", {"itemname": "Chicken Nuggets", "Quantity": 3});
    }, version: 1);
  }





  static Future<List<Item>> loadDataFromDatabase() async {


    List<Item> itemData = [];
    List<Map> itemTable = [];
    String dbPath = join(await getDatabasesPath(), 'item.db');
    print("loadData:" + dbPath);
    Database db = await openDatabase(dbPath);

    itemTable = await db.query("Item");
    print('Database:');
    for (Map dbItem in itemTable) {
      if (dbItem.isEmpty) {
        continue;
      }
      Item f = Item(dbItem["id"], dbItem["itemname"], dbItem["quantity"]);
      print(f.toString());
        itemData.add(f);
    }
    print('----------------------------------------');
    return itemData;
  }

  static void removeItemFromDatabase(String name) async {
    String dbPath = join(await getDatabasesPath(), 'item.db');
    print("deleteData:" + dbPath);
    Database db = await openDatabase(dbPath);
    print('Delete ID: $name');
    db.delete("Item",where: "itemname=?",whereArgs: [name]);
  }

  static void addEntryToDatabase(Item i) async {
    String dbPath = join(await getDatabasesPath(), 'item.db');
    Database db = await openDatabase(dbPath);

      db.insert("item", {"itemname": "${i.name}", "quantity": "${i.quantity}"},);
  }
}
