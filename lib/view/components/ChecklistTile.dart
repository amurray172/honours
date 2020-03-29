import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChecklistTile extends StatefulWidget {
  ChecklistTile({this.text, this.resetChecklist});
  final String text;
  final bool resetChecklist;

  @override
  _ChecklistTileState createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {

  bool _checked = false;
  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      title: Text(
        widget.text,
        style: TextStyle(
            color: Colors.blueAccent
        ),
      ),
      value: _checked,
      activeColor: Color(0xff6940e2),
      checkColor: Colors.white,
      onChanged: (bool value) {
        setState(() {
          _checked= value;
        });
      },
    );


  }



}


