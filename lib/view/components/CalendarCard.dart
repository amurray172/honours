import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
class CalendarCard extends StatefulWidget {
  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {

  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map) {
    Map<String,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        TableCalendar(
          events: _events,
          initialCalendarFormat: CalendarFormat.month,
          //Keep commented in case of emergency cause it sometimes doesnt work
          //locale: initializeDateFormatting('en_US', null).toString(),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            titleTextStyle: TextStyle(color: Colors.blueAccent),
            formatButtonDecoration: BoxDecoration(color: Colors.white),
            formatButtonTextStyle: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          calendarStyle: CalendarStyle(
            todayColor: Colors.blueAccent,
            selectedColor: Color(0xff6940e2),
            canEventMarkersOverflow: true,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: (date, events) {
            setState(() {
              _selectedEvents = events;
            });
          },
          builders: CalendarBuilders(
            selectedDayBuilder: (context, date, events) =>
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff6940e2),
                      borderRadius: BorderRadius.only(topRight: Radius.elliptical(10.0, 5.0), bottomLeft: Radius.elliptical(10.0, 5.0))
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
            todayDayBuilder: (context, date, events) =>
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(topRight: Radius.elliptical(10.0, 5.0), bottomLeft: Radius.elliptical(10.0, 5.0))
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
          ),
          calendarController: _controller,
        ),
        ..._selectedEvents.map((event) => ListTile(
          title: Text(event),
        )),
        FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _showAddDialog,
        ),
      ],
    );
  }
  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,
            decoration: InputDecoration(
              hintText: "Type event name here",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //borderSide: BorderSide(color: Color(0xff6940e2))
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(20.0, 10.0),
                    bottomLeft: Radius.elliptical(20.0, 10.0)
                ),
              ),
              child: Text(
                  "Add event to Calendar",
              ),
              onPressed: (){
                if(_eventController.text.isEmpty) return;
                setState(() {
                  if(_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay].add(_eventController.text);
                  }else{
                    _events[_controller.selectedDay] = [_eventController.text];
                  }
                  prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });
              },
            )
          ],
        )
    );
  }
}