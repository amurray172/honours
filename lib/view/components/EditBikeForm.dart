import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/Bike.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:intl/intl.dart';

class EditBikeForm extends StatefulWidget {
  EditBikeForm({ this.user, this.i});

  User user;
  final int i;

  @override
  _EditBikeFormState createState() => _EditBikeFormState();
}

class _EditBikeFormState extends State<EditBikeForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime _bikeYear;
  DateTime _currentMotDate;
  DateTime _currentServiceDate;
  DateTime _currentInsuranceDate;


  DateTime _newMotDate;
  DateTime _newServiceDate;
  DateTime _newInsuranceDate;
  DateTime _newYear;


  DateTime startDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(Duration(days: 365));

  Future<Null> _selectDate(BuildContext context, DateTime _date, String field) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: lastDate
    );
    if (picked != null && picked != startDate) {
      setState(() {
        switch (field) {
          case "mot":
            _newMotDate = picked;
            break;
          case "service":
            _newServiceDate = picked;
            break;
          case "insurance":
            _newInsuranceDate = picked;
            break;
          default:
            _date = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int i;
    setState(() {
      i = widget.i;
      _bikeYear = DateTime.parse(widget.user.bikes.elementAt(i)['year']);
      _currentMotDate = DateTime.parse(widget.user.bikes.elementAt(i)['motRenewalDate']);
      _currentServiceDate = DateTime.parse(widget.user.bikes.elementAt(i)['nextServiceDate']);
      _currentInsuranceDate = DateTime.parse(widget.user.bikes.elementAt(i)['insuranceRenewalDate']);
    });

    return SingleChildScrollView(
        child: AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 1.5,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "My ${widget.user.bikes.elementAt(i)['make']} ${widget.user.bikes.elementAt(i)['model']}'s details:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 22.0
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[

                    ],
                  )
                ),
                Column(
                  children: <Widget>[
                    Text("Bike Manufacture"),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(color: Color(0xff6940e2))
                            ),
                            hintText: widget.user.bikes.elementAt(i)['make'].toString()
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          bool required = false;
                          if (value.isEmpty && required == true) {
                            return 'Please enter this bikes manufacturer';
                          }
                        },
                        onSaved: (val) => setState(() => {
                            if (val.isEmpty && widget.user.bikes.elementAt(i)['make'] != null) {
                              widget.user.bikes.elementAt(i)['make'] = widget.user.bikes.elementAt(i)['make']
                            } else {
                              widget.user.bikes.elementAt(i)['make'] = val
                            }
                          }
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Bike Model"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['model'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the model of this bike';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['model'] != null) {
                                widget.user.bikes.elementAt(i)['model'] = widget.user.bikes.elementAt(i)['model']
                              } else {
                                widget.user.bikes.elementAt(i)['model'] = val
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Year of Manufacture"),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: _newYear == null ? Text("${_bikeYear.year}") : Text("${_newYear.year}"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: (
                            Text("Click to change year")
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Card(
                                          child: YearPicker(
                                              selectedDate: DateTime.now(),
                                              firstDate: DateTime(1940),
                                              lastDate: DateTime.now(),
                                              onChanged: (value) => {
                                                setState(() => {
                                                  _newYear = value,
                                                  Navigator.of(context).pop(false)
                                                })
                                              }
                                          )
                                      )
                              )
                          );

                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Colour"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['colour'].toString()
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the colour of this bike';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['colour'] != null ){
                                widget.user.bikes.elementAt(i)['colour'] = widget.user.bikes.elementAt(i)['colour']
                              } else {
                                widget.user.bikes.elementAt(i)['colour'] = val
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                    children: <Widget>[
                      Text("MOT Renewal Date"),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              _newMotDate == null
                                  ? "Date of next MOT - ${_currentMotDate.day}/${_currentMotDate.month}/${_currentMotDate.year}"
                                  : "Selected Date - ${_newMotDate.day}/${_newMotDate.month}/${_newMotDate.year}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                  _selectDate(context, _newMotDate, "mot");
                              },
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              child: Text("Click to select date"),
                            )
                          ],
                        ),
                      ),
                    ]
                ),
                Column(
                  children: <Widget>[
                    Text("Mileage at last MOT"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(color: Color(0xff6940e2))
                            ),
                            hintText: widget.user.bikes.elementAt(i)['mileageAtMot'].toString()
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          bool required = false;
                          if (value.isEmpty && required == true) {
                            return 'Please enter the mileage of this bike \n'
                                'as of it\'s last MOT';
                          }
                        },
                        onSaved: (val) => setState(() => {
                          if (val.isEmpty && widget.user.bikes.elementAt(i)['mileageAtMot'] != null) {
                            widget.user.bikes.elementAt(i)['mileageAtMot'] = widget.user.bikes.elementAt(i)['mileageAtMot']
                          } else {
                            widget.user.bikes.elementAt(i)['mileageAtMot'] = int.parse(val)
                          }
                        }
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Next Service Date"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            _newServiceDate == null
                                ? "Date of next service - ${_currentServiceDate.day}/${_currentServiceDate.month}/${_currentServiceDate.year}"
                                : "Selected Date - ${_newServiceDate
                                .day}/${_newServiceDate.month}/${_newServiceDate
                                .year}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .accentColor
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              _selectDate(context, _newServiceDate, "service");
                            },
                            color: Theme
                                .of(context)
                                .accentColor,
                            child: Text("Click to select date"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Mileage at last Service"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['mileageAtService'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the mileage of this bike \n'
                                  'as of it\'s last service';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['mileageAtService'] != null) {
                                widget.user.bikes.elementAt(i)['mileageAtService'] = widget.user.bikes.elementAt(i)['mileageAtService']
                              } else {
                                widget.user.bikes.elementAt(i)['mileageAtService'] = int.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Service interval (Miles)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['serviceInterval'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the recommended service \n'
                                  'interval for this bike \n'
                                  'e.g. enter 3000 if it\'s every 3000 miles';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['serviceInterval'] != null) {
                                widget.user.bikes.elementAt(i)['serviceInterval'] = widget.user.bikes.elementAt(i)['serviceInterval']
                              } else {
                                widget.user.bikes.elementAt(i)['serviceInterval'] = int.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Type of Insurance Cover e.g. Comprehensive"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['insuranceCoverType'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your type of insurance cover \n'
                                  'e.g. comprehensive, third party fire & theft \n'
                                  'etc.';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['insuranceCoverType'] != null) {
                                widget.user.bikes.elementAt(i)['insuranceCoverType'] = widget.user.bikes.elementAt(i)['insuranceCoverType']
                              } else {
                                widget.user.bikes.elementAt(i)['insuranceCoverType'] = val
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Last years Insurance Premium"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(color: Color(0xff6940e2))
                            ),
                            hintText: "£${widget.user.bikes.elementAt(i)['insurancePremium']}",
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your latest insurance \n'
                                  'premium for this bike';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['insurancePremium'] != null) {
                                widget.user.bikes.elementAt(i)['insurancePremium'] = widget.user.bikes.elementAt(i)['insurancePremium']
                              } else {
                                widget.user.bikes.elementAt(i)['insurancePremium'] = double.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Insurance Provider"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['insuranceProvider'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your insurance provider \n'
                                  'for this bike';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['insuranceProvider'] != null) {
                                widget.user.bikes.elementAt(i)['insuranceProvider'] = widget.user.bikes.elementAt(i)['insuranceProvider']
                              } else {
                                widget.user.bikes.elementAt(i)['insuranceProvider'] = val
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Insurance Renewal Date"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          Text(
                            _newInsuranceDate == null
                                ? "Insurance Renewal Date - ${_currentInsuranceDate.day}/${_currentInsuranceDate.month}/${_currentInsuranceDate.year}"
                                : "Selected Date - ${_newInsuranceDate
                                .day}/${_newInsuranceDate.month}/${_newInsuranceDate
                                .year}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .accentColor
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              _selectDate(
                                  context, _newInsuranceDate, "insurance");
                            },
                            color: Theme
                                .of(context)
                                .accentColor,
                            child: Text("Click to select date"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Total Insurance Excess (Compulsory + Voluntary)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: "£${widget.user.bikes.elementAt(i)['insuranceTotalExcess'].toString()}"
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the total amount of \n'
                                  'excess on your insurance policy \n '
                                  'i.e. compulsory + voluntary';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['insuranceTotalExcess'] != null) {
                                widget.user.bikes.elementAt(i)['insuranceTotalExcess'] = widget.user.bikes.elementAt(i)['insuranceTotalExcess']
                              } else {
                                widget.user.bikes.elementAt(i)['insuranceTotalExcess'] = double.parse(val)
                              }

                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Insurance Usage e.g. SDPC"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['insuranceUsage'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the usage of the \n'
                                  'bike as per your insurance policy \n '
                                  'e.g. SDPC, social only etc.';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['insuranceUsage'] != null) {
                                widget.user.bikes.elementAt(i)['insuranceUsage'] = widget.user.bikes.elementAt(i)['insuranceUsage']
                              } else {
                                widget.user.bikes.elementAt(i)['insuranceUsage'] = val
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Number of years No Claims"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['insuranceYearsNoClaims'].toString()
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the number of years \n '
                                  'no-claims bonus you have on this bikes polioy';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['insuranceYearsNoClaims'] != null) {
                                widget.user.bikes.elementAt(i)['insuranceYearsNoClaims'] = widget.user.bikes.elementAt(i)['insuranceYearsNoClaims']
                              } else {
                                widget.user.bikes.elementAt(i)['insuranceYearsNoClaims'] = int.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Full price of bike upon purchase"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: "£${widget.user.bikes.elementAt(i)['purchasePrice'].toString()}"
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the total cost \n '
                                  'of the bike at time of purchase';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['purchasePrice'] != null) {
                                widget.user.bikes.elementAt(i)['purchasePrice'] = widget.user.bikes.elementAt(i)['purchasePrice']
                              } else {
                                widget.user.bikes.elementAt(i)['purchasePrice'] = double.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Payment method e.g. finance (HP/PCP), or cash"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['purchaseType'].toString()
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the payment method \n'
                                  ' used to purchase/lease this bike \n '
                                  'e.g. PCP, HP or full price payment';
                            }
                          },
                        onSaved: (val) => setState(() => {
                            if (val.isEmpty && widget.user.bikes.elementAt(i)['purchaseType'] != null) {
                              widget.user.bikes.elementAt(i)['purchaseType'] = widget.user.bikes.elementAt(i)['purchaseType']
                            } else {
                              widget.user.bikes.elementAt(i)['purchaseType'] = val
                            }
                          }
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Value of additional Accessories \n "
                        "e.g. end can, crash protection etc. (if N/A, enter 0)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: "£${widget.user.bikes.elementAt(i)['valueOfAccessories'].toString()}"
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the amount of the \n '
                                  'optional final payment on your \n '
                                  'finance agreement';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['valueOfAccessories'] != null) {
                                widget.user.bikes.elementAt(i)['valueOfAccessories'] = widget.user.bikes.elementAt(i)['valueOfAccessories']
                              } else {
                                widget.user.bikes.elementAt(i)['valueOfAccessories'] = double.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Monthly payment amount (if N/A, enter 0)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: "£${widget.user.bikes.elementAt(i)['monthlyPayment'].toString()}"
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the monthly payment \n '
                                  'amount for this bike';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['monthlyPayment'] != null) {
                                widget.user.bikes.elementAt(i)['monthlyPayment'] = widget.user.bikes.elementAt(i)['monthlyPayment']
                              } else {
                                widget.user.bikes.elementAt(i)['monthlyPayment'] = double.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Optional Final Payment amount (if N/A, enter 0)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: "£${widget.user.bikes.elementAt(i)['optionalFinalPayment'].toString()}"
                          ),
                        // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the amount of the optional \n '
                                  'final payment on your finance agreement';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['optionalFinalPayment'] != null) {
                                widget.user.bikes.elementAt(i)['optionalFinalPayment'] = widget.user.bikes.elementAt(i)['optionalFinalPayment']
                              } else {
                                widget.user.bikes.elementAt(i)['optionalFinalPayment'] = double.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Finance Contract Length (Months), \n if N/A, enter 0)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['financeContractLength'].toString()
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your finance contract \n '
                                  'length for this bike e.g. 36 months';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['financeContractLength'] != null) {
                                widget.user.bikes.elementAt(i)['financeContractLength'] = widget.user.bikes.elementAt(i)['financeContractLength']
                              } else {
                                widget.user.bikes.elementAt(i)['financeContractLength'] = int.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Estimated annual mileage on finance deal (if N/A, enter 0)"),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(0xff6940e2))
                              ),
                              hintText: widget.user.bikes.elementAt(i)['financeEstimatedMileage'].toString()
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the estimated annual mileage \n '
                                  'for this bike as per your insurance policy';
                            }
                          },
                          onSaved: (val) => setState(() => {
                              if (val.isEmpty && widget.user.bikes.elementAt(i)['financeEstimatedMileage'] != null) {
                                widget.user.bikes.elementAt(i)['financeEstimatedMileage'] = widget.user.bikes.elementAt(i)['financeEstimatedMileage']
                              } else {
                                widget.user.bikes.elementAt(i)['financeEstimatedMileage'] = int.parse(val)
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: SizedBox(
                        width: 100.0,
                        child: RaisedButton(
                          onPressed: () {
                            final form = _formKey.currentState;
                            if(form.validate()) {
                              form.save();
                              if(_newMotDate == null) {
                                _newMotDate = DateTime.parse(widget.user.bikes.elementAt(i)['motRenewalDate']);
                              }else if(_newServiceDate == null) {
                                _newServiceDate = DateTime.parse(widget.user.bikes.elementAt(i)['nextServiceDate']);
                              }else if(_newInsuranceDate == null) {
                                _newInsuranceDate = DateTime.parse(widget.user.bikes.elementAt(i)['insuranceRenewalDate']);
                              }else if(_newYear == null) {
                                _newYear = DateTime.parse(widget.user.bikes.elementAt(i)['year']);
                              }
                              setState(() {
                                widget.user.bikes.elementAt(i)['motRenewalDate'] = _newMotDate == null ? widget.user.bikes.elementAt(i)['motRenewalDate'] : _newMotDate.toIso8601String();
                                widget.user.bikes.elementAt(i)['nextServiceDate'] = _newServiceDate == null ? widget.user.bikes.elementAt(i)['nextServiceDate'] :_newServiceDate.toIso8601String();
                                widget.user.bikes.elementAt(i)['insuranceRenewalDate'] = _newInsuranceDate == null ? widget.user.bikes.elementAt(i)['insuranceRenewalDate'] :_newInsuranceDate.toIso8601String();
                                widget.user.bikes.elementAt(i)['year'] = _newYear == null ? widget.user.bikes.elementAt(i)['year'] : _newYear.toIso8601String();
                                widget.user = widget.user;
                                updateUser(widget.user);
                              });
                            }
                          },
                         child: Text("Save"),
                        ),
                      )
                  ),
                ),
            ]),
          ),
        )
    );
  }
}

