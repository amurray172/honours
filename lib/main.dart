import 'package:flutter/material.dart';
import 'Home.dart';



void main() async => runApp(MyApp());


/*
 routes: <String, WidgetBuilder> {
    "/bikepage": (BuildContext context) => new BikePage(),
    "/profilepage": (BuildContext context) => new ProfilePage()
  },
 */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik',
      ),
      home: Home(),
    );//Home;
  }
}







