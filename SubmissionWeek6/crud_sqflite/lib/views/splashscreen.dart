import 'dart:async';
import 'package:crud_sqflite/models/model_user.dart';
import 'package:crud_sqflite/sqflite/db_helper.dart';
import 'package:crud_sqflite/views/home.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => cekLogin());
    super.initState();
  }

  Future cekLogin() async {
    DatabaseHelper db = DatabaseHelper();
    ModelUser user = await db.getOnline();
    if (user == null) {
      Navigator.pushReplacementNamed(context, Login.routeName);
    } else {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png")),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "CRUD SQFlite \nMahasiswa",
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
