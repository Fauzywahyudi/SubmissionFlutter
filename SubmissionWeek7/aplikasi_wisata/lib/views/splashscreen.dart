import 'dart:async';

import 'package:aplikasi_wisata/tests/home.dart';
import 'package:aplikasi_wisata/views/home_page.dart';
import 'package:aplikasi_wisata/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () => getCurrentUser());
    super.initState();
  }

  void nextPage(Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  Future getCurrentUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    // print("User: ${_user.displayName ?? "None"}");
    if (_user != null) {
      nextPage(HomePage(
        user: _user,
      ));
    } else {
      nextPage(LoginPage());
    }

    return _user;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: 'icon', child: Image.asset('assets/images/icon.png')),
            SizedBox(height: 40),
            Text(
              'Aplikasi Wisata\nSumbar',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'McLaren'),
            ),
          ],
        ),
      ),
    );
  }
}
