import 'package:flutter/material.dart';

class User {
  int? id;
  String name;
  String email;
  String password;
  //constructeur
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  //methode
  static Map<String, dynamic> toMap(id, name, email, password) {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
