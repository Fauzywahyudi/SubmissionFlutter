import 'package:aplikasi_notes/models/user.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
