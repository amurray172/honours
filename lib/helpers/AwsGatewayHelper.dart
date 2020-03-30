import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:honours/model/User.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser(String username) async {
  final response =
  await http.get(
      Uri.encodeFull('https://tl0gmb1a3e.execute-api.eu-west-2.amazonaws.com/prod/users/${username}'),
      headers: {
        "Accept": "application/json"
      }
   );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.;

    if(response.body == "") {
      return new User(username: "");
    } else {
      return User.fromJson(json.decode(response.body));
    }
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    return new User(username: "", email: "", password: "", );
    throw Exception('Failed to load user');
  }
}


Future<http.Response> updateUser(jsonMap) async {

  dynamic bikesList = jsonMap.bikes;
  for(int i=0; i<bikesList.length; i++) {
    bikesList[i]['motRenewalDate'] = bikesList[i]['motRenewalDate'].toString();
    bikesList[i]['nextServiceDate'] = bikesList[i]['nextServiceDate'].toString();
    bikesList[i]['insuranceRenewalDate'] = bikesList[i]['insuranceRenewalDate'].toString();
  }
  String url = 'https://tl0gmb1a3e.execute-api.eu-west-2.amazonaws.com/prod/users/${jsonMap.username}/';
  var response = await http.post(
    Uri.encodeFull(url),
    headers: {"Accept": "application/json"},
    body: json.encode(jsonMap),
  );

  return response;
}

Future<http.Response> addUser(jsonMap) async {

  String url = 'https://tl0gmb1a3e.execute-api.eu-west-2.amazonaws.com/prod/users/${jsonMap.username}/';
  var response = await http.post(
    Uri.encodeFull(url),
    headers: {"Accept": "application/json"},
    body: json.encode(jsonMap),
  );
  return response;
}

Future<http.Response> deleteUser(String username) async {

  String url = 'https://tl0gmb1a3e.execute-api.eu-west-2.amazonaws.com/prod/users/$username/';

  var response = await http.delete(
    Uri.encodeFull(url),
  );
  return response;
}