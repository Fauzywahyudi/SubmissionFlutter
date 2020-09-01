import 'dart:async';
import 'package:ecommerce/models/shared_preferenced.dart';
import 'package:ecommerce/models/status_login.dart';
import 'package:ecommerce/views/build_home.dart';
import 'package:ecommerce/views/build_login.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User _user;
  DataShared _dataShared = DataShared();
  StatusLogin _statusLogin = StatusLogin.notSignIn;

  Future _getValuePref() async {
    final value = await _dataShared.getValue();
    if (value == 1) {
      _statusLogin = StatusLogin.signIn;
      _user = await _dataShared.getDataPref();
    }
    setState(() {});
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  void initState() {
    _getValuePref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_statusLogin) {
      case StatusLogin.notSignIn:
        return BuildLogin();
        break;
      case StatusLogin.signIn:
        return BuildHome(
          user: _user,
        );
        break;
    }
  }
}
