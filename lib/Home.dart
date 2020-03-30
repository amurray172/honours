import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/AddNewBikeForm.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:honours/view/page_containers/HomePageContainer.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'viewmodel/BikePage.dart';
import 'viewmodel/HomePage.dart';
import 'viewmodel/ProfilePage.dart';

class Home extends StatefulWidget {
  Home({this.user});
  User user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  TextStyle optionStyle = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );

  User usableUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      new BikePage(user: widget.user),
      new HomePage(user: widget.user),
      new ProfilePage(user: widget.user),
    ];
    bool showFloatingActionButton = false;
    return Scaffold(
      //backgroundColor: Color(0xff6940e2),
      appBar: AppBar(
        title: Text("Motodocs"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: widget.user,)));},
            child: Image(
              image: AssetImage('assets/appbar.png'),
            )
          ),
        ],
        //backgroundColor: Color(0xff6940e2),
      ),
      body: _children.elementAt(_selectedIndex),

      //_children.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Color(0xff6940e2),
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