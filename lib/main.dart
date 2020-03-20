import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Home.dart';



void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'en_GB';
    return MaterialApp(
      title: 'Honours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff6940e2),
        accentColor: Colors.blueAccent,
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: Color(0xff6940e2),
        canvasColor: Color(0xff6940e2),
      ),
      home: Home(),
    );//Home;
  }
}







