import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/Bike.dart';
import '../components/HomeCards.dart';
class HomePageContainer extends StatefulWidget {
  HomePageContainer({Key key, this.title, List bikesList}) : super(key: key);
  final String title;


  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {


  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xffeeeeee),
      child: new Card(
          shape: RoundedRectangleBorder(
            side: new BorderSide(
              color: Color(0xff6940e2),
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(80.0, 40.0),
                bottomLeft: Radius.elliptical(80.0, 40.0)
            ),
          ),
        child: HomeCards()
      )
    );
  }
}








