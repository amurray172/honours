import 'dart:convert';
import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:mongo_dart_query/mongo_dart_query.dart';

void main() async => runApp(MyApp());

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

  void _connectDb() async {
    mongo_dart.Db db = new mongo_dart.Db('mongodb://10.0.2.2:27017/motodocs');
    await db.open();

    print("connected to database " + db.databaseName);

    mongo_dart.DbCollection coll = db.collection('bikes');
    //read bikes
    var bikes = await coll.find().toList();
    print(bikes[0]);
    //var bike = await coll.findOne(where.eq("make", "BMW").and(where.eq("model", "S1000RR")));

    //create bikes

    /*
    await coll.save({
      "make": "BMW",
      "model": "S1000RR"
    });

    print("saved new bike");

     */

    //update bikes

    /*
    await coll.update(await coll.findOne(where.eq("model", "GS500E")), {
      r"$set": {"make" : "Yamaha"}
    });
    print ("Updated bike");
    print(bikes);

    */

    //delete bikes
    /*
    print(bikes);
    await coll.remove(await coll.findOne(where.eq("make", "Yamaha")));

    print("Removed bike");
    print(bikes);

    */
    await db.close();
  }



  @override
  Widget build(BuildContext context) {
    this._connectDb();
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
          icon: new Icon(Icons.motorcycle),
          title: new Text('Bikes'),
        ),
        BottomNavigationBarItem(
            icon: new Icon(Icons.home), title: new Text('Home')),
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

