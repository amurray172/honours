import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import '../../model/Bike.dart';
import '../components/BikeCards.dart';
class BikePageContainer extends StatefulWidget {
  BikePageContainer({Key key, this.title, this.user, List bikesList}) : super(key: key);
  final String title;
  final User user;

  @override
  _BikePageContainerState createState() => _BikePageContainerState();
}

class _BikePageContainerState extends State<BikePageContainer> {


  @override
  Widget build(BuildContext context) {

    Bike bike1 = Bike(make: "Triumph", model: "Street Triple R", year: 2018, colour: "black");


    List<Bike> bikesList = [];

    for(int i = 0; i < widget.user.bikes.length; i++) {
      print(widget.user.bikes.elementAt(i).toString());
      final String make = widget.user.bikes.elementAt(i)['make'];
      final String model = widget.user.bikes.elementAt(i)['model'];
      final int year = int.parse(widget.user.bikes.elementAt(i)['year']);
      final String colour = widget.user.bikes.elementAt(i)['colour'];

      Bike newBike = new Bike(make: make, model: model, year: year, colour: colour);
      bikesList.add(newBike);
    }

    return Container(
    color: Color(0xffeeeeee),
      child: new ListView.builder(
          itemCount: bikesList.length,
          itemBuilder: (BuildContext context, int i) =>
              GestureDetector(
                onTap: (){
                  setState(() {
                    print("hello");
                  });
                },
                child: BikeCards(context: context, i: i, bikesList: bikesList,),
              )
            //BikeCards(context: context, i: i, bikesList: bikesList,),
        ),
      );
  }
}








