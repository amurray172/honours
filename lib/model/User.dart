import 'Bike.dart';

class User {
  String username;
  String password;
  String email;
  List<dynamic> bikes;

  User({this.username,this.password,this.email,this.bikes,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      bikes: json['bikes']
    );
  }

  Map<String,dynamic> get map {
    return {
      "username": username,
      "password": password,
      "email": email,
      "bikes": bikes,
    };
  }


}