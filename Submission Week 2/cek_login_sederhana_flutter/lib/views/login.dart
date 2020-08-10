import 'dart:ui';

import 'package:cek_login_sederhana_flutter/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = true;
  TextEditingController _tecUsername = TextEditingController();
  TextEditingController _tecPassword = TextEditingController();
  FocusNode _focUsername = FocusNode();
  FocusNode _focPassword = FocusNode();

  var _shadow = BoxShadow(
    color: Colors.blueGrey,
    blurRadius: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildLogin(),
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildLogin() {
    return SafeArea(
      child: Container(
        color: Colors.blue[100],
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _buildClip(),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sosmed() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(EvaIcons.google, color: Colors.red),
              onPressed: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                EvaIcons.facebook,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                EvaIcons.twitter,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Column _buildForm() {
    return Column(
      children: <Widget>[
        _buildLoginHeader(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              boxShadow: [_shadow],
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: TextField(
            focusNode: _focUsername,
            controller: _tecUsername,
            textInputAction: TextInputAction.next,
            onSubmitted: (v) {
              FocusScope.of(context).requestFocus(_focPassword);
            },
            decoration: InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Icons.person),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              boxShadow: [_shadow],
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: TextField(
            focusNode: _focPassword,
            controller: _tecPassword,
            obscureText: _showPassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (v) {
              _focPassword.unfocus();
            },
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
              border: InputBorder.none,
              suffixIcon: IconButton(
                  icon: _showPassword
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  }),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 50,
              ),
              FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () => _prosesLogin(),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue,
                      )),
                ),
                isExtended: true,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Login With",
              style: GoogleFonts.lato(
                  fontSize: 17,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold)),
        ),
        _sosmed()
      ],
    );
  }

  Container _buildLoginHeader() {
    return Container(
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/images/sigin.svg"),
            ),
          ),
          Text(
            "Login System",
            style: GoogleFonts.mcLaren(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Container _buildClip() {
    return Container(
      height: 480,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
    );
  }

  void _prosesLogin() {
    if (_tecUsername.text == "admin" && _tecPassword.text == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            username: _tecUsername.text,
            password: _tecPassword.text,
          ),
        ),
      );
    } else if (_tecUsername.text == "" || _tecPassword.text == "") {
      _buildDialog(DialogType.INFO, "Login Failed",
          "Username atau Password tidak boleh kosong!");
    } else {
      _buildDialog(
          DialogType.ERROR, "Login Failed", "Username atau Password Salah!");
    }
  }

  _buildDialog(DialogType tipe, String title, String msg) {
    return AwesomeDialog(
        context: context,
        dialogType: tipe,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        desc: msg,
        btnOkOnPress: () {},
        btnOkColor: Colors.blue)
      ..show();
  }
}
