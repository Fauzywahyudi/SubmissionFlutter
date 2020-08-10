import 'package:cek_login_sederhana_flutter/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Home extends StatefulWidget {
  final username;
  final password;

  const Home({Key key, this.username, this.password}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var boxShadow2 =
      BoxShadow(color: Colors.black12, spreadRadius: 10, blurRadius: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: MediaQuery.of(context).size.height * 0.5 - 24,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Parsing Data",
                              style: GoogleFonts.lato(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _buildListTile("Username", widget.username),
                          Divider(
                            indent: 15,
                          ),
                          _buildListTile("Password", widget.password),
                          Divider(
                            indent: 15,
                          ),
                          RaisedButton.icon(
                              onPressed: () => _logout(),
                              color: Colors.blue,
                              textColor: Colors.white,
                              icon: Icon(Icons.exit_to_app),
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Logout"),
                              ))
                        ],
                      )),
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
                      // _buildAppBar(),
                      SizedBox(height: 30),
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
      ),
    );
  }

  ListTile _buildListTile(String property, String value) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          text: '$property : ',
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: <TextSpan>[
            TextSpan(
              text: ' $value',
              style: GoogleFonts.mcLaren(
                  fontWeight: FontWeight.bold, color: Colors.blue),
            )
          ],
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
}
