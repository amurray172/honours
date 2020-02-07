import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honours',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik',
      ),
      home: MyHomePage(title: 'Honours Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> bikesList = ["GS500E", "GSXR1000", "Ninja 650"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: cardTemplate(context)),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget cardTemplate(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemCount: bikesList.length,
          itemBuilder: (BuildContext context, int i) =>
              buildBikeCard(context, i)),
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
            icon: new Icon(Icons.home), title: new Text('Home')),
        BottomNavigationBarItem(
          icon: new Icon(Icons.motorcycle),
          title: new Text('Bikes'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }

  Widget buildBikeCard(BuildContext context, int i) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            bikesList[i],
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
