import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCards extends StatelessWidget {
  final BuildContext context;
  final int i;
  ProfileCards({this.context, this.i});
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                "Profile Page",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24.0,
                ),
              )
          ),
        )
    );
  }
}