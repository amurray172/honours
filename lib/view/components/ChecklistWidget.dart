import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/ChecklistTile.dart';

class ChecklistWidget extends StatefulWidget {
  ChecklistWidget({this.user});
  User user;
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
            child: ChecklistTile(
                text: "Lights",
                isChecked: widget.user.checklistItems.elementAt(0)['lights'],
                elementType: 'lights',
                user: widget.user
            )
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Steering",
                  isChecked: widget.user.checklistItems.elementAt(0)['steering'],
                  elementType: 'steering',
                  user: widget.user
              )
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Suspension",
                  isChecked: widget.user.checklistItems.elementAt(0)['suspension'],
                  elementType: 'suspension',
                  user: widget.user
              )
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Wheels & Tyres",
                  isChecked: widget.user.checklistItems.elementAt(0)['wheelsAndTyres'],
                  elementType: 'wheelsAndTyres',
                  user: widget.user
              )
          ),
          SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Frame",
                  isChecked: widget.user.checklistItems.elementAt(0)['frame'],
                  elementType: 'frame',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Braking",
                  isChecked: widget.user.checklistItems.elementAt(0)['braking'],
                  elementType: 'braking',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Exhaust",
                  isChecked: widget.user.checklistItems.elementAt(0)['exhaust'],
                  elementType: 'exhaust',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Fuel system",
                  isChecked: widget.user.checklistItems.elementAt(0)['fuel'],
                  elementType: 'fuel',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                text: "Sidecar (if applicable)",
                  isChecked: widget.user.checklistItems.elementAt(0)['sidecar'],
                  elementType: 'sidecar',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Registration plates, VIN and Frame numbers",
                  isChecked: widget.user.checklistItems.elementAt(0)['registration'],
                  elementType: 'registration',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Throttle",
                  isChecked: widget.user.checklistItems.elementAt(0)['throttle'],
                  elementType: 'throttle',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Clutch lever",
                  isChecked: widget.user.checklistItems.elementAt(0)['clutch'],
                  elementType: 'clutch',
                  user: widget.user
              )
          ),SizedBox(
              width: 500.0,
              height: 50.0,
              child: ChecklistTile(
                  text: "Footrests",
                  isChecked: widget.user.checklistItems.elementAt(0)['footrests'],
                  elementType: 'footrests',
                  user: widget.user
              )
          ),
        ],
      )
    );
  }
}

