import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'Home.dart';



void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Keep commented in case of emergency cause it sometimes doesnt work
    //Intl.defaultLocale = initializeDateFormatting("en_GB", null).toString();
    final primaryColor = Color(0xff6940e2);
    final accentColor = Colors.blueAccent;
    final whiteColor = Colors.white;
    final primarySwatch = Colors.blue;
    return MaterialApp(
      title: 'Honours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatch,
        primaryColor: primaryColor,
        accentColor: accentColor,
        buttonTheme: ButtonThemeData(
          buttonColor: accentColor,
          textTheme: ButtonTextTheme.primary,
        ),
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: primaryColor,
        canvasColor: primaryColor,
      ),
      home: Home(),
    );//Home;
  }
}







