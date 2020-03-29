import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/Home.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/AddNewBikeForm.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import 'package:honours/view/components/Register.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:honours/view/page_containers/HomePageContainer.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:password/password.dart';
import 'viewmodel/BikePage.dart';
import 'viewmodel/HomePage.dart';
import 'viewmodel/ProfilePage.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  final _loginKey = GlobalKey<FormState>();

  String username;
  String password;
  String errorMessage = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400.0,
          width: 500.0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(80.0, 40.0),
                bottomLeft: Radius.elliptical(80.0, 40.0)),
            child: Container(
                color: Color(0xffeeeeee),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50.0,
                          width: 500.0,
                          child: Text(
                            "Welcome to Motodocs!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 24.0
                            ),
                          ),
                        ),
                      ),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0
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
                              bool required = true;
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
                              bool required = true;
                              if (value.isEmpty && required == true) {
                                return "Please enter your password";
                              }
                            },
                            onSaved: (val) => setState(() => {
                              password = Password.hash(val, PBKDF2())
                            }
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
                                  final form = _loginKey.currentState;
                                  if(form.validate()) {
                                    form.save();
                                  }
                                  var user = await fetchUser(username);

                                  if(user.username == username && user.password == password) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user,)));
                                  } else if (user.username != username || user.password != password)  {
                                    setState(() {
                                      errorMessage = "Username or password did not match an account on our records";
                                    });
                                  }


                                },
                                child: Text("Log in"),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                },
                                child: Text("Register"),
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
      ),
    );
  }


}
