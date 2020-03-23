import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import '../../model/Bike.dart';
import '../../model/User.dart';
class BikeCards extends StatefulWidget {
  BikeCards({this.context, this.i, this.user});

  final BuildContext context;
  final int i;
  final User user;

  @override
  _BikeCardsState createState() => _BikeCardsState();

}

class _BikeCardsState extends State<BikeCards> {
  @override
  Widget build(BuildContext context) {
    var i = widget.i;
        return new Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: new BorderSide(
              color: Color(0xff6940e2),
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(80.0, 40.0),
                bottomLeft: Radius.elliptical(80.0, 40.0)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Text(
                  widget.user.bikes.elementAt(i)['make'],
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  widget.user.bikes.elementAt(i)['model'].toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  widget.user.bikes.elementAt(i)['year'].toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  widget.user.bikes.elementAt(i)['colour'],
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                )
              ],
            ),
          ),
        );
  }

}