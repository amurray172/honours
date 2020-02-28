import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:honours/view/page_containers/HomePageContainer.dart';

import 'viewmodel/BikePage.dart';
import 'viewmodel/HomePage.dart';
import 'viewmodel/ProfilePage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  final List<Widget> _children = [
    BikePage(),
    HomePage(),
    ProfilePage(),
  ];
  TextStyle optionStyle = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6940e2),
      appBar: AppBar(
        title: Text("Motodocs"),
        actions: <Widget>[
          Image(
            image: AssetImage('assets/garage_large.png'),
          )
        ],
        backgroundColor: Color(0xff6940e2),
      ),
      body: _children.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff6940e2),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.motorcycle,
              color: Colors.white,
            ),
            title: new Text(
              'Bikes',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: new Text(
                'Home',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ), title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          )
          )
        ],
      ),
    );
  }
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

}