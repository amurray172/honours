import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import '../../model/Bike.dart';
import '../components/HomeCards.dart';
class HomePageContainer extends StatefulWidget {
  HomePageContainer({Key key, this.title, this.user, List bikesList}) : super(key: key);
  final String title;
  final User user;

  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {


  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xffeeeeee),
        child: SingleChildScrollView(
          child: HomeCards(user: widget.user),
        ),
    );
  }
}








