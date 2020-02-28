/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../viewmodel/BikePage.dart';

import '../../viewmodel/ProfilePage.dart';
class BottomNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    BikePage(),
    ProfilePage(),
  ];
  TextStyle optionStyle = TextStyle(
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xff6940e2),
      currentIndex: 1,
      onTap: _onItemTapped,
      selectedFontSize: 16.0,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(
            Icons.motorcycle,
            color: Colors.white,
          ),
          title: new Text(
            'Bikes',
            style: optionStyle,
          ),
        ),
        BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: new Text(
              'Home',
              style: optionStyle,
            )
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ), title: Text(
          'Profile',
          style: optionStyle,
        )
        )
      ],
    );
  }

  void _onItemTapped(int index){
      setState(() {
        _currentIndex = index;
      });
      switch(_currentIndex){
        case 0:
          {Navigator.of(context).pushNamed("/bikepage");} {}
          break;
        case 1:
          {Navigator.of(context).pushNamed("/");} {}
          break;
        case 2:
            {Navigator.of(context).pushNamed("/profilepage");} {}
          break;
        default:
            {Navigator.of(context).pushNamed("/");} {}
          break;
      }
  }
}
*/