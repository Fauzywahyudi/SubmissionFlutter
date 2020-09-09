import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/link.dart' as link;
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/views/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // DataShared _dataShared = DataShared();

  @override
  void initState() {
    Timer(Duration(seconds: 3), () => pushReplacePage(context, Login()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      body: Container(
        decoration: BoxDecoration(
          color: colSecondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(
                link.Link.asset + "logo.svg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Movie App",
              style: GoogleFonts.mcLaren(
                color: colPrimary,
                fontSize: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
