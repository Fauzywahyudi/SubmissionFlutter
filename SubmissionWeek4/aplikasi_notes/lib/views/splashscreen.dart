import 'dart:async';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:aplikasi_notes/views/login.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_notes/utils/link.dart' as link;
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => _cekLogin());
    super.initState();
  }

  void _cekLogin() {
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
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(link.Link.asset + "logo.png"),
            ),
            Text(
              "Notes App",
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
