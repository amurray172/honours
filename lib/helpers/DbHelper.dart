import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart_query/mongo_dart_query.dart';
import 'dart:io';
import 'dart:ui' as prefix0;
import 'dart:convert';
import 'dart:math';
void main() async => {
  /*int port = 8000;
      var server = await HttpServer.bind('localhost', port, shared: true);
      */
  Db db = new Db('mongodb://10.0.2.2:27017/motodocs'),

  await db.open();

  print("connected to database " + db.databaseName);

  mongo_dart.DbCollection coll = db.collection('bikes');

  /*server.listen((HttpRequest request) {
        request.response.write("Hello World!");
        request.response.close();
      });*/


  //read bikes
  var bikes = await coll.find().toList();

  //var bike = await coll.findOne(where.eq("make", "BMW").and(where.eq("model", "S1000RR")));

  //create bikes


  await coll.save({
  "make": "BMW",
  "model": "S1000RR"
  });

  print("saved new bike");



  //update bikes


  await coll.update(await coll.findOne(where.eq("model", "GS500E")), {
  r"$set": {"make" : "Yamaha"}
  });
  print ("Updated bike");
  print(bikes);



  //delete bikes

  print(bikes);
  await coll.remove(await coll.findOne(where.eq("make", "Yamaha")));

  print("Removed bike");
  print(bikes);


  await db.close();
};
