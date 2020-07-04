import 'package:flutter/material.dart';

class EditItem extends StatefulWidget {
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eintrag ändern"),
      ),
      body: Container(
        child: Slider(
          min: 0,
          max: 50,
          divisions: 5,
          value: 10,
          label: "Anzahl der Objekte",
        ),
      ),
    );
  }
}
