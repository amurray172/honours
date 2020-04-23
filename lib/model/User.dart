import 'Bike.dart';

class User {
  String username;
  String password;
  String email;
  List<dynamic> checklistItems;
  List<dynamic> bikes;

  User({this.username,this.password,this.email, this.checklistItems, this.bikes,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      checklistItems: json['checklistItems'],
      bikes: json['bikes']
    );
  }

  Map<String,dynamic> get map {
    return {
      "username": username,
      "password": password,
      "email": email,
      "checklistItems": checklistItems,
      "bikes": bikes,
    };
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
    "checklistItems": checklistItems,
    "bikes": bikes,
  };
}