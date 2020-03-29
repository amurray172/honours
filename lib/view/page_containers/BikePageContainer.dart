import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/AddNewBikeForm.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import 'package:intl/intl.dart';
import '../../model/Bike.dart';
import '../components/BikeCards.dart';
class BikePageContainer extends StatefulWidget {
  BikePageContainer({Key key, this.title, this.user, List bikesList}) : super(key: key);
  final String title;
  User user;

  @override
  _BikePageContainerState createState() => _BikePageContainerState();

}

class _BikePageContainerState extends State<BikePageContainer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = new List<String>.generate(widget.user.bikes.length, (i) => "Items ${i+1}");
    //print("Test ${widget.user.bikes.elementAt(2).map}");
    return Container(
      color: Color(0xffeeeeee),
      child: new ListView.builder(
          itemCount: widget.user.bikes.length + 1,
          itemBuilder: (BuildContext context, int i) {
            if(i == (widget.user.bikes.length)) {
              return Padding(
                padding: EdgeInsets.all(4.0),
                child: Center(
                  child: RaisedButton(
                    child: SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.add),
                          ),
                          Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text("Add a new bike")
                          )
                        ],
                      ),
                    ),
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return new AddNewBikeForm(
                                user: widget.user,
                              );
                            }
                        ).then((user) {
                          setState(() {
                            user = widget.user;
                          });
                        });
                      }
                  ),
                ),
              );
            } else {
              return Container(
                width: 500.0,
                child: new GestureDetector(
                  child: new Dismissible(
                    key: new Key(items[i]),
                    child: BikeCards(
                      context: context,
                      i: i,
                      user: widget.user,
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        items.removeAt(i);
                        widget.user.bikes.removeAt(i);
                        Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("Bike Deleted")));
                      });
                    },
                    // ignore: missing_return
                    confirmDismiss: (DismissDirection direction) async {
                      final bool res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: Text(
                                "Are you sure you wish to permanantly delete your ${widget
                                    .user.bikes.elementAt(i)['make']}"
                                    " ${widget.user.bikes.elementAt(
                                    i)['model']}? This cannot be undone"),
                            actions: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.user.bikes.removeAt(i);
                                    widget.user = widget.user;
                                    updateUser(widget.user);
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text(
                                  "Delete",
                                ),
                                color: Color(0xff6940e2),
                              ),
                              FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xff6940e2)
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return new EditBikeForm(
                              user: widget.user,
                              i: i
                          );
                        }
                    ).then((user) {
                      setState(() {
                        user = widget.user;
                        i = i;
                      });
                    });
                  },
                ),
              );
            }
          }
        ),
      );
  }

}








