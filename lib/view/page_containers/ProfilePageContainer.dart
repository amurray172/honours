import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import '../components/ProfileCards.dart';
import '../../model/Bike.dart';
import '../components/HomeCards.dart';
class ProfilePageContainer extends StatefulWidget {
  ProfilePageContainer({Key key, this.title, this.user, List bikesList}) : super(key: key);
  final String title;
  final User user;

  @override
  _ProfilePageContainerState createState() => _ProfilePageContainerState();
}

class _ProfilePageContainerState extends State<ProfilePageContainer> {


  @override
  Widget build(BuildContext context) {

    return Container(
        color: Color(0xffeeeeee),
        child: new Card(
            shape: RoundedRectangleBorder(
              side: new BorderSide(
                //color: Color(0xff6940e2),
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(80.0, 40.0),
                  bottomLeft: Radius.elliptical(80.0, 40.0)
              ),
            ),
            child: ProfileCards()
        )
    );
  }
}








