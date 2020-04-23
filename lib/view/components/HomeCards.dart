import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/ChecklistWidget.dart';
import './CalendarCard.dart';

class HomeCards extends StatelessWidget {
  HomeCards({this.context, this.i, this.user});
  final BuildContext context;
  final int i;
  final User user;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CalendarCard(),
                  ),
                  shape: RoundedRectangleBorder(
                    side:  new BorderSide(
                      color: Color(0xff6940e2),
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(80.0, 40.0),
                      bottomLeft: Radius.elliptical(80.0, 40.0),
                    )
                  ),
               ),
               Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ChecklistWidget(user: user),
                  ),
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(
                    color: Color(0xff6940e2),
                  ),
                 borderRadius: BorderRadius.only(
                   topRight: Radius.elliptical(80.0, 40.0),
                        bottomLeft: Radius.elliptical(80.0, 40.0),
                    ),
                  ),
                ),
              ],
            )
          ),
      )
    );
  }
}