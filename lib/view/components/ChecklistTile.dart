import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/User.dart';

class ChecklistTile extends StatefulWidget {
  ChecklistTile({this.text, this.resetChecklist, this.isChecked, this.elementType, this.user });
  final String text;
  final bool resetChecklist;
  bool isChecked;
  String elementType;
  User user;


  @override
  _ChecklistTileState createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      title: Text(
        widget.text,
        style: TextStyle(
            color: Colors.blueAccent
        ),
      ),
      value: widget.isChecked,
      activeColor: Color(0xff6940e2),
      checkColor: Colors.white,
      onChanged: (bool value) {
        setState(() {
          widget.isChecked = value;
          widget.user.checklistItems.elementAt(0)['${widget.elementType}'] = value;
        });
      },
    );


  }



}


