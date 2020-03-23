import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/Bike.dart';
import 'package:honours/model/User.dart';
import '../view/page_containers/BikePageContainer.dart';
import '../view/components/BottomNavBar.dart';
class BikePage extends StatefulWidget {
  BikePage({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _BikePageState createState() => _BikePageState();
}

class _BikePageState extends State<BikePage> {
  @override
  Widget build(BuildContext context) {
      return Center(
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(80.0, 40.0),
                bottomLeft: Radius.elliptical(80.0, 40.0)
            ),
            child: BikePageContainer(title: "Honours", user: widget.user)
        ),
      );
  }
}