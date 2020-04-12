import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/viewmodel/Login.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/User.dart';
import 'package:password/password.dart';

class ProfileCards extends StatefulWidget {
  ProfileCards({this.context, this.i, this.user});

  final BuildContext context;
  final int i;
  final User user;

  @override
  _ProfileCardsState createState() => _ProfileCardsState();
}

class _ProfileCardsState extends State<ProfileCards> {
  final _updateEmailKey = GlobalKey<FormState>();
  final _updatePasswordKey = GlobalKey<FormState>();

  String newEmail;
  String currentPassword;
  String newPassword;
  String confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Center(
        child: SingleChildScrollView(
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
                                fontSize: 22.0),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Username - ${widget.user.username}",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor
                                ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Number of bikes stored - ${widget.user.bikes.length}",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor
                              ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Email address - ${widget.user.email}",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor
                              ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: RaisedButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Update email address: ${widget.user.email}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),
                                      ),
                                      content: SizedBox(
                                        height: 75.0,
                                        child: Form(
                                          key: _updateEmailKey,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: new BorderSide(color: Color(
                                                            0xff6940e2))
                                                    ),
                                                    hintText: "New email address"
                                                ),
                                                // ignore: missing_return
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter your new email address';
                                                  }
                                                },
                                                onSaved: (val) =>
                                                    setState(() =>
                                                      {
                                                        newEmail = val
                                                      }
                                                    ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        RaisedButton(
                                          onPressed: () {
                                            final form = _updateEmailKey.currentState;
                                            form.save();
                                            widget.user.email = newEmail;
                                            updateUser(widget.user);
                                          },
                                          child: const Text(
                                            "Update",
                                          ),
                                          color: Color(0xff6940e2),
                                        ),
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff6940e2)),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("Change email address"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: RaisedButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Update your password",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Form(
                                          key: _updatePasswordKey,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  obscureText: true,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: new BorderSide(color: Color(
                                                              0xff6940e2))
                                                      ),
                                                      hintText: "Confirm current password"
                                                  ),
                                                  // ignore: missing_return
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your current password';
                                                    }
                                                  },
                                                  onSaved: (val) =>
                                                      setState(() =>
                                                      {
                                                        currentPassword = Password.hash(val, new PBKDF2())
                                                      }
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  obscureText: true,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: new BorderSide(color: Color(
                                                              0xff6940e2))
                                                      ),
                                                      hintText: "New Password"
                                                  ),
                                                  // ignore: missing_return
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your new password';
                                                    }
                                                  },
                                                  onSaved: (val) =>
                                                      setState(() =>
                                                      {
                                                        newPassword = Password.hash(val, new PBKDF2())
                                                      }
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  obscureText: true,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: new BorderSide(color: Color(
                                                              0xff6940e2))
                                                      ),
                                                      hintText: "Confirm new Password"
                                                  ),
                                                  // ignore: missing_return
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please confirm your new password';
                                                    }
                                                  },
                                                  onSaved: (val) =>
                                                      setState(() =>
                                                      {
                                                        confirmNewPassword = Password.hash(val, new PBKDF2())
                                                      }
                                                      ),
                                                )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        RaisedButton(
                                          onPressed: () {
                                            final form = _updatePasswordKey.currentState;
                                            form.save();
                                            if(currentPassword == widget.user.password && newPassword == confirmNewPassword) {
                                              setState(() {
                                                widget.user.password = newPassword;
                                              });
                                              updateUser(widget.user);
                                              Navigator.of(context).pop(false);
                                            }
                                          },
                                          child: const Text(
                                            "Update",
                                          ),
                                          color: Color(0xff6940e2),
                                        ),
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff6940e2)),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("Change password"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: RaisedButton(
                              onPressed: () {
                                updateUser(widget.user);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
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
                            child: RaisedButton(
                              color: Colors.red,
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Delete user: ${widget.user.username}"),
                                      content: Text(
                                          "Are you sure you wish to permanantly delete your account? This cannot be undone"),
                                      actions: <Widget>[
                                        RaisedButton(
                                          onPressed: () {
                                            deleteUser(widget.user.username);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
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
                                                color: Color(0xff6940e2)),
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
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
