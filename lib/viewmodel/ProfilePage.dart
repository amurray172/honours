import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/page_containers/ProfilePageContainer.dart';
import '../view/page_containers/BikePageContainer.dart';
import '../view/components/BottomNavBar.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(

      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(80.0, 40.0),
              bottomLeft: Radius.elliptical(80.0, 40.0)
          ),
          child: ProfilePageContainer(title: "Honours")
      ),
    );;
  }
}