import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import '../view/page_containers/HomePageContainer.dart';

class HomePage extends StatefulWidget {
  HomePage( {Key key, this.user }) : super(key: key);
  final User user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
      return Center(
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(80.0, 40.0),
              bottomLeft: Radius.elliptical(80.0, 40.0)
          ),
          child: HomePageContainer(title: "Honours", user: widget.user)
      ),
    );
  }
}