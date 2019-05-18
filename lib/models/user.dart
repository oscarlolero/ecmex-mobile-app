import 'package:flutter/material.dart';
class User {
  final String id;
  final String username;
  final bool isAdmin;

  User({@required this.id, @required this.username, @required this.isAdmin});
}