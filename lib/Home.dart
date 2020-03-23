import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:honours/view/page_containers/HomePageContainer.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
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

  var user = fetchUser();
  TextStyle optionStyle = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Color(0xff6940e2),
      appBar: AppBar(
        title: Text("Motodocs"),
        actions: <Widget>[
          Image(
            image: AssetImage('assets/appbar.png'),
          )
        ],
        //backgroundColor: Color(0xff6940e2),
      ),
      body: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Text("");
              break;
            case ConnectionState.active:
              return Text("");
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white
                  //valueColor: Colors.blueAccent,
                ),
              );
              break;
            case ConnectionState.done:
              List<Widget> _children = [
                new BikePage(user: (snapshot.hasData) ? snapshot.data : snapshot.error),
                new HomePage(user: snapshot.hasData ? snapshot.data : snapshot.error),
                new ProfilePage(user: snapshot.hasData ? snapshot.data : snapshot.error),
              ];
              return _children.elementAt(_selectedIndex);
              break;
            default:
              return Text("Default");
          }
        },
      ),
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