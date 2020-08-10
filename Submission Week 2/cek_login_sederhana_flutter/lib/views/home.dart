import 'package:cek_login_sederhana_flutter/views/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Home extends StatefulWidget {
  final username;

  const Home({Key key, this.username}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var boxShadow2 =
      BoxShadow(color: Colors.black12, spreadRadius: 10, blurRadius: 10);
  List<IconData> _iconList = [
    EvaIcons.facebook,
    EvaIcons.twitter,
    EvaIcons.github,
    EvaIcons.google
  ];
  List<String> _titleList = ["Facebook", "Twitter", "Github", "Google"];
  List<Color> _colorList = [
    Colors.blue,
    Colors.lightBlue,
    Colors.black,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  height: MediaQuery.of(context).size.height * 0.5 - 24,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () => _whenTap(
                            _titleList[i], _iconList[i], _colorList[i]),
                        child: Card(
                          elevation: 5,
                          color: Colors.blue[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                _iconList[i],
                                color: _colorList[i],
                                size: 30,
                              ),
                              Text(
                                _titleList[i],
                                style: GoogleFonts.mcLaren(
                                    color: _colorList[i], fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: _iconList.length,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                  boxShadow: [boxShadow2],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.lightBlue[200]],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildAppBar(),
                    _buildText(),
                    Expanded(child: Container()),
                    _buildImage(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        boxShadow: [
          boxShadow2,
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SvgPicture.asset("assets/images/wellcome.svg"),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Wellcome \"${widget.username.toString().toUpperCase()}\"",
          style: GoogleFonts.mcLaren(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              tooltip: "Logout",
              onPressed: () => _logout(),
            ),
          ],
        )
      ],
    );
  }

  void _logout() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Logout',
      desc: 'Apa anda yakin untuk logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      },
    )..show();
  }

  _whenTap(String title, IconData icon, Color color) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      customHeader: Icon(
        icon,
        size: 40,
        color: color,
      ),
      title: title,
      desc: '',
      btnOkOnPress: () {},
    )..show();
  }
}
