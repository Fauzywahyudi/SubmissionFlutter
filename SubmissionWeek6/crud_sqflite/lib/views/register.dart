import 'package:crud_sqflite/models/model_user.dart';
import 'package:crud_sqflite/sqflite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  static String routeName = "/Register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _tecUsername = TextEditingController();
  var _tecPassword = TextEditingController();
  var _tecNama = TextEditingController();
  bool _obscure = true;

  Future _register() async {
    DatabaseHelper db = DatabaseHelper();
    ModelUser user = ModelUser(
        _tecUsername.text, _tecNama.text, _tecPassword.text, 'offline');
    await db.saveUser(user).then((_) => Navigator.pop(context));
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
                "Register",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _tecNama,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              OutlineButton(
                color: Colors.blue,
                onPressed: () => _register(),
                child: Text(
                  "Register",
                  style: GoogleFonts.mcLaren(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
