import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/Bike.dart';
import '../components/BikeCards.dart';
class BikePageContainer extends StatefulWidget {
  BikePageContainer({Key key, this.title, List bikesList}) : super(key: key);
  final String title;


  @override
  _BikePageContainerState createState() => _BikePageContainerState();
}

class _BikePageContainerState extends State<BikePageContainer> {


  @override
  Widget build(BuildContext context) {

    Bike bike1 = Bike(make: "Triumph", model: "Street Triple R", manufactureYear: 2018, color: "black");
    Bike bike2 = Bike(make: "Suzuki", model: "GS500E", manufactureYear: 1996, color: "red");
    Bike bike3 = Bike(make: "BMW", model: "S1000RR", manufactureYear: 2014, color: "blue");

    List<Bike> bikesList = [];

    bikesList.add(bike1);
    bikesList.add(bike2);
    bikesList.add(bike3);

    return Container(
    color: Color(0xffeeeeee),
      child: new ListView.builder(
          itemCount: bikesList.length,
          itemBuilder: (BuildContext context, int i) =>
            BikeCards(context: context, i: i, bikesList: bikesList,),
        ),
      );
  }
}








