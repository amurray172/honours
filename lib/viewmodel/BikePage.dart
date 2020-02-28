import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/page_containers/BikePageContainer.dart';
import '../view/components/BottomNavBar.dart';
class BikePage extends StatefulWidget {
  BikePage({Key key, this.title}) : super(key: key);
  final String title;

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
            child: BikePageContainer(title: "Honours")
        ),
      );
  }
}