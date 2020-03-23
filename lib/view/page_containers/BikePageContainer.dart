import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import 'package:intl/intl.dart';
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

    final _animatedListKey = GlobalKey<AnimatedListState>();
    List<Bike> bikesList = [];

    for(int i = 0; i < widget.user.bikes.length; i++) {

      final String make = widget.user.bikes.elementAt(i)['make'];
      final String model = widget.user.bikes.elementAt(i)['model'];
      final int year = int.parse(widget.user.bikes.elementAt(i)['year']);
      final String colour = widget.user.bikes.elementAt(i)['colour'];
      final DateTime motRenewalDate = new DateFormat("dd/MM/yyyy", "en_GB").parse(widget.user.bikes.elementAt(i)['motRenewalDate']);
      final int mileageAtMot = int.parse(widget.user.bikes.elementAt(i)['mileageAtMot']);
      final DateTime lastServiceDate = new DateFormat("dd/MM/yyyy", "en_GB").parse(widget.user.bikes.elementAt(i)['lastServiceDate']);
      final int mileageAtService = int.parse(widget.user.bikes.elementAt(i)['mileageAtService']);
      final int serviceInterval = int.parse(widget.user.bikes.elementAt(i)['serviceInterval']);
      final String insuranceCoverType = widget.user.bikes.elementAt(i)['insuranceCoverType'];
      final double insurancePremium = double.parse(widget.user.bikes.elementAt(i)['insurancePremium']);
      final String insuranceProvider = widget.user.bikes.elementAt(i)['insuranceProvider'];
      final DateTime insuranceRenewalDate = new DateFormat("dd/MM/yyyy", "en_GB").parse(widget.user.bikes.elementAt(i)['insuranceRenewalDate']);
      final double insuranceTotalExcess = double.parse(widget.user.bikes.elementAt(i)['insuranceTotalExcess']);
      final String insuranceUsage = widget.user.bikes.elementAt(i)['insuranceUsage'];
      final int insuranceYearsNoClaims = int.parse(widget.user.bikes.elementAt(i)['insuranceYearsNoClaims']);
      final double purchasePrice = double.parse(widget.user.bikes.elementAt(i)['purchasePrice']);
      final String purchaseType = widget.user.bikes.elementAt(i)['purchaseType'].toString();
      final double valueOfAccessories = double.parse(widget.user.bikes.elementAt(i)['valueOfAccessories']);
      final double monthlyPayment = double.parse(widget.user.bikes.elementAt(i)['monthlyPayment']);
      final double optionalFinalPayment = double.parse(widget.user.bikes.elementAt(i)['optionalFinalPayment']);
      final int financeContractLength = int.parse(widget.user.bikes.elementAt(i)['financeContractLength']);
      final int financeEstimatedMileage = int.parse(widget.user.bikes.elementAt(i)['financeEstimatedMileage']);

      Bike newBike = new Bike(
          make: make,
          model: model,
          year: year,
          colour: colour,
          motRenewalDate: motRenewalDate,
          mileageAtMot: mileageAtMot,
          lastServiceDate: lastServiceDate,
          mileageAtService: mileageAtService,
          serviceInterval: serviceInterval,
          insuranceCoverType: insuranceCoverType,
          insurancePremium: insurancePremium,
          insuranceProvider: insuranceProvider,
          insuranceRenewalDate: insuranceRenewalDate,
          insuranceTotalExcess: insuranceTotalExcess,
          insuranceUsage: insuranceUsage,
          insuranceYearsNoClaims: insuranceYearsNoClaims,
          purchasePrice: purchasePrice,
          purchaseType: purchaseType,
          valueOfAccessories: valueOfAccessories,
          monthlyPayment: monthlyPayment,
          optionalFinalPayment: optionalFinalPayment,
          financeContractLength: financeContractLength,
          financeEstimatedMileage: financeEstimatedMileage,
      );
      bikesList.add(newBike);
    }

    return Container(
      color: Color(0xffeeeeee),
      child: new ListView.builder(
          itemCount: widget.user.bikes.length,
          itemBuilder: (BuildContext context, int i) => Container(
            child: new GestureDetector(
              child: BikeCards(context: context, i: i, user: widget.user,),
              onTap: (){
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return new EditBikeForm(user: widget.user, i: i);
                    }
                );
              },
            ),
          )
        ),
    );
  }
}








