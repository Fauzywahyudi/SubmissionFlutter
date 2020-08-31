import 'dart:async';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/views/login.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/link.dart' as link;
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => _toLogin());
    super.initState();
  }

  void _toLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepOrange[200],
            colPrimary,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Image.asset(link.Link.asset + "logo.png"),
            ),
            SizedBox(height: 20),
            Text(
              "Ecommerce App",
              style: GoogleFonts.mcLaren(
                color: colSecondary,
                fontSize: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
