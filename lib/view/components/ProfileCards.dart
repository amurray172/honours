import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/Login.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/User.dart';

class ProfileCards extends StatelessWidget {
  ProfileCards({this.context, this.i, this.user});
  final BuildContext context;
  final int i;
  final User user;
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    side: new BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(80.0, 40.0),
                      bottomLeft: Radius.elliptical(80.0, 40.0),
                    ),
                ),
                child: SizedBox(
                    width: 500.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                "Current User Details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 22.0
                                ),
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Username - ${user.username}")
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Number of bikes stored - ${user.bikes.length}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Email address - ${user.email}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child:  RaisedButton(
                              onPressed: () {},
                              child: Text("Change email address"),
                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child:  RaisedButton(
                              onPressed: () {},
                              child: Text("Change password"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child:  RaisedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                              },
                              child: Text("Log out"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child:  RaisedButton(
                              color: Colors.red,
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete user: ${user.username}"),
                                      content: Text(
                                          "Are you sure you wish to permanantly delete your account? This cannot be undone"),
                                      actions: <Widget>[
                                        RaisedButton(
                                          onPressed: () {
                                            deleteUser(user.username);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                              child: Text("Delete Account"),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
    );
  }
}
