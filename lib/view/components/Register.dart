import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/viewmodel/Home.dart';
import 'package:honours/viewmodel/Login.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/AddNewBikeForm.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:honours/view/page_containers/HomePageContainer.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:password/password.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {

  final _registerKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  String confirmPassword = "";
  String email = "";
  List bikes = [];

  User checkUsername = new User();

  String errorMessage = "";
  int numBikesAdded = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    User newUser = new User(
        username: username,
        password: password,
        email: email,
        bikes: bikes
    );

    return Scaffold(
      body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(80.0, 40.0),
                bottomLeft: Radius.elliptical(80.0, 40.0)),
            child: Container(
              color: Color(0xffeeeeee),
              child: SingleChildScrollView(
                child: Form(
                  key: _registerKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 75.0,
                          width: 500.0,
                          child: Text(
                            errorMessage == "" ? "Enter your details below" : "An account with that username already exists",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: errorMessage == "" ? Theme.of(context).accentColor : Colors.red,
                                fontSize: 24.0
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350.0,
                          height: 75.0,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Color(0xff6940e2))
                                ),
                                hintText: "Username"
                            ),
                            // ignore: missing_return
                            validator: (value) {
                              bool required = false;
                              if (value.isEmpty && required == true) {
                                return "Please enter your username";
                              }
                            },
                            onSaved: (val) => setState(() => {
                              username = val
                            }
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350.0,
                          height: 75.0,
                          child: TextFormField(
                            obscureText: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Color(0xff6940e2))
                                ),
                                hintText: "Email Address"
                            ),
                            // ignore: missing_return
                            validator: (value) {
                              bool required = true;
                              if (value.isEmpty && required == true) {
                                return "Please enter your Email Address";
                              } else if (validateEmail(value) == false) {
                                return "Please enter a valid email address";
                              }
                            },
                            onSaved: (val) => setState(() => {
                              email = val.toString()
                            }
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350.0,
                          height: 75.0,
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Color(0xff6940e2))
                                ),
                                hintText: "Password"
                            ),
                            // ignore: missing_return
                            validator: (value) {
                              bool required = false;
                              if (value.isEmpty && required == true) {
                                return "Please enter your username";
                              }
                            },
                            onSaved: (val) => setState(() => {
                              password = Password.hash(val, new PBKDF2())
                            }
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350.0,
                          height: 75.0,
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Color(0xff6940e2))
                                ),
                                hintText: "Confirm Password"
                            ),
                            // ignore: missing_return
                            validator: (value) {
                              bool required = false;
                              if (value.isEmpty && required == true) {
                                return "Please enter your password";
                              }
                            },
                            onSaved: (val) => setState(() => {
                              confirmPassword = Password.hash(val, new PBKDF2())
                            }
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Number of bikes added: ${newUser.bikes.length}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return new AddNewBikeForm(
                                    user: newUser,
                                  );
                                }
                            ).then((user) {
                              setState(() {
                                user = newUser;
                              });
                            });
                          },
                          child: Text(
                            "Click here to add a Bike",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15.0
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 120.0,
                              height: 40.0,
                              child: RaisedButton(
                                // ignore: missing_return
                                onPressed: () async {
                                  final form = _registerKey.currentState;
                                  bool usernameValid = false;
                                  checkUsername = await fetchUser(username);
                                  print(username);
                                  if(checkUsername.username == "" || checkUsername.username == null) {
                                    setState(() {
                                      usernameValid = true;
                                    });
                                  } else {
                                    setState(() {
                                      usernameValid = false;
                                    });
                                  }
                                  if(form.validate()) {
                                    if(usernameValid == false) {
                                      setState(() {
                                        errorMessage = "Account with this username already exists";
                                      });
                                    } else {
                                      if(Password.verify(password, Password.hash(password, PBKDF2())) == Password.verify(confirmPassword, Password.hash(confirmPassword, PBKDF2()))) {
                                        form.save();
                                        List<dynamic> checklistItems = [];
                                        Map checklistItemsMap = new Map();
                                        checklistItemsMap['lights'] = false;
                                        checklistItemsMap['steering'] = false;
                                        checklistItemsMap['suspension'] = false;
                                        checklistItemsMap['wheelsAndTyres'] = false;
                                        checklistItemsMap['frame'] = false;
                                        checklistItemsMap['braking'] = false;
                                        checklistItemsMap['exhaust'] = false;
                                        checklistItemsMap['fuel'] = false;
                                        checklistItemsMap['sidecar'] = false;
                                        checklistItemsMap['registration'] = false;
                                        checklistItemsMap['throttle'] = false;
                                        checklistItemsMap['clutch'] = false;
                                        checklistItemsMap['footrests'] = false;
                                        checklistItems.add(checklistItemsMap);
                                        setState(() {
                                          errorMessage = "";
                                          newUser = new User(
                                            username: username,
                                            email: email,
                                            password: password,
                                            checklistItems: checklistItems,
                                            bikes: bikes,
                                          );
                                        });
                                        //print(newUser.username);
                                        updateUser(newUser);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                      }else {
                                        setState(() {
                                          errorMessage = "Passwords don't match";
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Text("Register"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 120.0,
                              height: 40.0,
                              child: RaisedButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: Text("Cancel"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}
