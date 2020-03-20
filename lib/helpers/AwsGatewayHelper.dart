import 'dart:async';
import 'dart:convert';
import 'package:honours/model/User.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
  final response =
  await http.get(
      Uri.encodeFull('https://tl0gmb1a3e.execute-api.eu-west-2.amazonaws.com/prod/users/Andy172'),
      headers: {
        "Accept": "application/json"
      }
   );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}