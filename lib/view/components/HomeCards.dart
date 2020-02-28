import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './CalendarCard.dart';

class HomeCards extends StatelessWidget {
  final BuildContext context;
  final int i;
  HomeCards({this.context, this.i});
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: CalendarCard(),
          ),
      )
    );
  }
}