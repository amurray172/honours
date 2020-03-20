import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import '../../model/Bike.dart';
import '../../model/User.dart';
class BikeCards extends StatelessWidget {
  final BuildContext context;
  final int i;
  final List<Bike> bikesList;
  final User user;
  BikeCards({this.context, this.i, this.bikesList, this.user});

  @override
  Widget build(BuildContext context) {

    return new Container(
        child: GestureDetector(
          onTap: () => (){},
          child: Card(
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
                    bikesList[i].make,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    bikesList[i].model,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    bikesList[i].year.toString(),
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    bikesList[i].colour,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }

}