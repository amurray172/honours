import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/Bike.dart';
import 'package:honours/model/User.dart';
import 'package:honours/view/page_containers/BikePageContainer.dart';
import 'package:intl/intl.dart';


class AddNewBikeForm extends StatefulWidget {
  AddNewBikeForm({this.user});

  User user;

  @override
  _AddNewBikeFormState createState() => _AddNewBikeFormState();
}

class _AddNewBikeFormState extends State<AddNewBikeForm> {
  final _addBikeKey = GlobalKey<FormState>();

  DateTime _motDate;
  DateTime _serviceDate;
  DateTime _insuranceDate;
  DateTime _newYear;

  DateTime startDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(Duration(days: 365));


  Future<Null> _selectDate(BuildContext context, DateTime _date,
      String field) async {
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
            _motDate = picked;
            break;
          case "service":
            _serviceDate = picked;
            break;
          case "insurance":
            _insuranceDate = picked;
            break;
          default:
            _date = picked;
        }
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String make;
    String model;
    String colour;
    int mileageAtMot;
    int mileageAtService;
    int serviceInterval;
    String insuranceCoverType;
    double insurancePremium;
    double insuranceTotalExcess;
    String insuranceUsage;
    int insuranceYearsNoClaims;
    String insuranceProvider;
    double purchasePrice;
    String purchaseType;
    double valueOfAccessories;
    double monthlyPayment;
    double optionalFinalPayment;
    int financeContractLength;
    int financeEstimatedMileage;

    return SingleChildScrollView(
        child: AlertDialog(
          content: Form(
            key: _addBikeKey,
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
                            "Please enter as many details as you wish to store for your bike below",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .accentColor,
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Manufacturer"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = true;
                            if (value.isEmpty && required == true) {
                              return 'Please enter this bikes manufacturer';
                            }
                          },
                          onSaved: (val) =>
                            setState(() =>
                            {
                              make = val
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Model"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = true;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the model of this bike';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                model = val
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
                        child: _newYear == null ? Text("Please select a year", style: TextStyle(color: Theme.of(context).accentColor),) : Text("Selected year - ${_newYear.year}"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: (
                              Text("Click to choose a year")
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Colour"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the colour of this bike';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty){
                                  colour = "No colour saved"
                                } else
                                  {
                                    colour = val
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
                                _motDate == null
                                    ? "Please Select a Date"
                                    : "Selected Date - ${_motDate
                                    .day}/${_motDate.month}/${_motDate.year}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .accentColor
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  _selectDate(context, _motDate, "mot");
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Mileage at last MOT"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the mileage of this\n'
                                  'bike as of it\'s last MOT';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  mileageAtMot = 0
                                } else
                                  mileageAtMot = int.parse(val)
                              }
                              ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Date of next Service"),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[

                            Text(
                              _serviceDate == null
                                  ? "Please Select a Date"
                                  : "Selected Date - ${_serviceDate
                                  .day}/${_serviceDate.month}/${_serviceDate
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
                                _selectDate(context, _serviceDate, "service");
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Mileage at last service"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the mileage of this bike \n'
                                  'as of it\'s last service';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  mileageAtService = 0
                                } else
                                  {
                                    mileageAtService = int.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Recommended service interval"
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
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  serviceInterval = 0
                                } else
                                  {
                                    serviceInterval = int.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Type of insurance e.g. Comprehensive/Third Party Fire & Theft"
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
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  insuranceCoverType = "No cover type stored"
                                } else
                                  {
                                    insuranceCoverType = val
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
                                borderSide: new BorderSide(color: Color(
                                    0xff6940e2))
                            ),
                            hintText: "Latest insurance premium",
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your latest insurance \n'
                                  'premium for this bike';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  insurancePremium = 0.0
                                } else
                                  {
                                    insurancePremium = double.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Insurance Provider"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your insurance provider \n'
                                  'for this bike';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty ) {
                                  insuranceProvider =
                                  "No insurance provider stored"
                                } else
                                  {
                                    insuranceProvider = val
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
                              _insuranceDate == null
                                  ? "Please Select a Date"
                                  : "Selected Date - ${_insuranceDate
                                  .day}/${_insuranceDate.month}/${_insuranceDate
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
                                    context, _insuranceDate, "insurance");
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Total excess on insurance policy"
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
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  insuranceTotalExcess = 0.0
                                } else
                                  {
                                    insuranceTotalExcess = double.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Usage as stated on insurance policy"
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
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  insuranceUsage = "Insurance usage not stored"
                                } else
                                  {
                                    insuranceUsage = val
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Number of years No Claims"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the number of years \n '
                                  'no-claims bonus you have on this bikes polioy';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  insuranceYearsNoClaims = 0
                                } else
                                  {
                                    insuranceYearsNoClaims = int.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Total purchase price"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the total cost \n '
                                  'of the bike at time of purchase';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  purchasePrice = 0.0
                                } else
                                  {
                                    purchasePrice = double.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Type of purchase e.g. Full price, PCP or HP"
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
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  purchaseType = "Purchase type not stored"
                                } else
                                  {
                                    purchaseType = val
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Total value of accessories"
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
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  valueOfAccessories = 0.0
                                } else
                                  {
                                    valueOfAccessories = double.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Monthly Payment"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the monthly payment \n '
                                  'amount for this bike';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  monthlyPayment = 0.0
                                } else
                                  {
                                    monthlyPayment = double.parse(val)
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
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Optional Final Payment"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the amount of the optional \n '
                                  'final payment on your finance agreement';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  optionalFinalPayment = 0.0
                                } else
                                  {
                                    optionalFinalPayment = double.parse(val)
                                  }
                              }
                              ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                          "Finance Contract Length (Months), \n if N/A, enter 0)"),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Contract Length"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter your finance contract \n '
                                  'length for this bike e.g. 36 months';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  financeContractLength = 0
                                } else
                                  {
                                    financeContractLength = int.parse(val)
                                  }
                              }
                              ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                          "Estimated annual mileage on finance deal (if N/A, enter 0)"),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Color(
                                      0xff6940e2))
                              ),
                              hintText: "Estimated Mileage(Finance)"
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            bool required = false;
                            if (value.isEmpty && required == true) {
                              return 'Please enter the estimated annual mileage \n '
                                  'for this bike as per your insurance policy';
                            }
                          },
                          onSaved: (val) =>
                              setState(() =>
                              {
                                if (val.isEmpty) {
                                  financeEstimatedMileage = 0
                                } else
                                  {
                                    financeContractLength = int.parse(val)
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
                              final form = _addBikeKey.currentState;
                              Bike newBike = new Bike();
                              if (form.validate()) {
                                form.save();
                                setState(() {
                                  if(_newYear == null) {
                                    _newYear = DateTime.now();
                                  }else if (_motDate == null) {
                                    _motDate = DateTime.now();
                                  }else if (_serviceDate == null) {
                                    _serviceDate = DateTime.now();
                                  }else if (_insuranceDate == null) {
                                    _insuranceDate = DateTime.now();
                                  }
                                  newBike = new Bike(
                                    make: make.toString(),
                                    model: model.toString(),
                                    year: _newYear == null ? DateTime.now().toIso8601String() : _newYear.toIso8601String(),
                                    colour: colour,
                                    motRenewalDate: _motDate == null ? DateTime.now().toIso8601String() : _motDate.toIso8601String(),
                                    mileageAtMot: mileageAtMot,
                                    nextServiceDate: _serviceDate == null ? DateTime.now().toIso8601String() : _serviceDate.toIso8601String(),
                                    mileageAtService: mileageAtService,
                                    serviceInterval: serviceInterval,
                                    insuranceCoverType: insuranceCoverType,
                                    insurancePremium: insurancePremium,
                                    insuranceProvider: insuranceProvider,
                                    insuranceRenewalDate: _insuranceDate == null ? DateTime.now().toIso8601String() : _insuranceDate.toIso8601String(),
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
                                });

                                widget.user.bikes.add(newBike.map);

                                setState(() {
                                  widget.user = widget.user;
                                  updateUser(widget.user);
                                  Navigator.of(context).pop(false);
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