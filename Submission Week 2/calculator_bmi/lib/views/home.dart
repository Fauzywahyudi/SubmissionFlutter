import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  static const routeName = '/Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _dirImage = "assets/images/";
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Gender",
                    style:
                        GoogleFonts.mcLaren(fontSize: 25, color: Colors.purple),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (!isMale) isMale = true;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: isMale ? Colors.purple : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: SvgPicture.asset(
                                          _dirImage + "man.svg",
                                          color: isMale
                                              ? Colors.white
                                              : Colors.purple)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Male",
                                      style: GoogleFonts.mcLaren(
                                          fontSize: 20,
                                          color: isMale
                                              ? Colors.white
                                              : Colors.purple),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isMale) isMale = false;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color:
                                    !isMale ? Colors.pinkAccent : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: SvgPicture.asset(
                                          _dirImage + "woman.svg",
                                          color: !isMale
                                              ? Colors.white
                                              : Colors.pinkAccent)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Male",
                                      style: GoogleFonts.mcLaren(
                                          fontSize: 20,
                                          color: !isMale
                                              ? Colors.white
                                              : Colors.pinkAccent),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
