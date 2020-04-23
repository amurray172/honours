import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/viewmodel/Home.dart';
import 'package:honours/helpers/EmailHelper.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/components/AddNewBikeForm.dart';
import 'package:honours/view/components/EditBikeForm.dart';
import 'package:honours/view/components/Register.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:honours/view/page_containers/HomePageContainer.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:password/password.dart';
import 'BikePage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  final _loginKey = GlobalKey<FormState>();
  final _forgotPasswordKey = GlobalKey<FormState>();
  String username;
  String forgotPasswordUsername;
  String password;
  User checkUsername = new User();
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
          height: 500.0,
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
                      FlatButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  title: Text("Forgot my Password", textAlign: TextAlign.center,),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Please enter your username below, and an email will be sent to the address linked to this account",
                                            style: TextStyle(
                                                color: Theme.of(context).accentColor
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Form(
                                            key: _forgotPasswordKey,
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: new BorderSide(color: Color(0xff6940e2))
                                                  ),
                                                  hintText: "Username"
                                              ),
                                              onSaved: (value) {
                                                setState(() {
                                                  forgotPasswordUsername = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  final form = _forgotPasswordKey.currentState;
                                                  form.save();
                                                  checkUsername = await fetchUser(forgotPasswordUsername);
                                                  if(checkUsername.username == "") {
                                                    setState(() {
                                                      errorMessage = "No account with that username exists on our records";
                                                      Navigator.of(context).pop(false);
                                                    });
                                                  } else {
                                                    setState(() {
                                                      EmailHelper eh = new EmailHelper();
                                                      eh.sendEmail(checkUsername, checkUsername.email);
                                                      errorMessage="An email has been sent to the account linked with your motodocs profile with your new password."
                                                          "Please log in and change your password straight away to maintain your accounts security.";
                                                    });
                                                  }
                                                },
                                                child: Text("Send email"),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: FlatButton(
                                                onPressed: (){
                                                  Navigator.of(context).pop(false);
                                                },
                                                child: Text("Cancel"),
                                              )
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                );
                              }
                          ).then((email) {
                            setState(() {

                            });
                          });
                        },
                        child: Text(
                          "Forgot your password",
                          style: TextStyle(
                              color: Theme.of(context).accentColor
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
