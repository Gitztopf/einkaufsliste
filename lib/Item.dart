class Item {
  int databaseID;
  String name;
  int quantity;
  Item(this.databaseID, this.name, this.quantity);

  @override
  String toString() {
    return 'Item{DatabaseID: $databaseID, Name: $name, Quantity: $quantity}';
  }
}
