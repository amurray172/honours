import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/view/components/ChecklistTile.dart';

class ChecklistWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChecklistWidgetState();

}

class _ChecklistWidgetState extends State<ChecklistWidget> {


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "MOT Checklist",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 18.0
            ),
          ),
          SizedBox(
            width: 500.0,
            height: 50.0,
            child: ChecklistTile(text: "Lights")
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Steering")
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Suspension")
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Wheels & Tyres")
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Frame")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Braking")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Exhaust")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Fuel system")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Sidecar (if applicable)")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Registration plates, VIN and Frame numbers")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Throttle")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Clutch lever")
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(text: "Footrests")
          ),
        ],
      )
    );
  }
}

