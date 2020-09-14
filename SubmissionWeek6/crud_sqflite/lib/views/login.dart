import 'package:crud_sqflite/models/model_user.dart';
import 'package:crud_sqflite/sqflite/db_helper.dart';
import 'package:crud_sqflite/views/home.dart';
import 'package:crud_sqflite/views/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  static String routeName = "/Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _tecUsername = TextEditingController();
  var _tecPassword = TextEditingController();
  bool _obscure = true;

  Future _login() async {
    DatabaseHelper db = DatabaseHelper();
    ModelUser user = await db.getLogin(_tecUsername.text, _tecPassword.text);
    if (user.id != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print("login gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                color: Colors.blue,
                child: SvgPicture.asset("assets/images/logo.svg"),
              ),
              SizedBox(height: 20),
              Text(
                "Login",
                style: GoogleFonts.mcLaren(fontSize: 25, color: Colors.blue),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _tecUsername,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _tecPassword,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: _obscure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              OutlineButton(
                onPressed: () => _login(),
                child: Text(
                  "Login",
                  style: GoogleFonts.mcLaren(color: Colors.blue),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun? ",
                    style: GoogleFonts.lato(),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Register.routeName),
                    child: Text(
                      "Daftar disini!",
                      style: GoogleFonts.mcLaren(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
