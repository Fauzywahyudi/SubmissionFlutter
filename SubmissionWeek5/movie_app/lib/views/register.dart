import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/utils/assets.dart';
// import 'package:movie_app/utils/custom_path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/link.dart' as link;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _tecEmail = TextEditingController();
  var _tecPassword = TextEditingController();
  var _tecNama = TextEditingController();
  var _tecNohp = TextEditingController();
  var _tecAlamat = TextEditingController();

  // var _focEmail = FocusNode();
  // var _focPassword = FocusNode();
  // var _focNama = FocusNode();
  // var _focNohp = FocusNode();
  // var _focAlamat = FocusNode();

  final _keyForm = GlobalKey<FormState>();

  String jenisKelamin = "";

  @override
  void initState() {
    super.initState();
  }

  void _register() async {
    final result = await http.post(link.Link.server + "register.php", body: {
      "email": _tecEmail.text,
      "password": _tecPassword.text,
      "nama": _tecNama.text,
      "nohp": _tecNohp.text,
      "alamat": _tecAlamat.text,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    print(pesan);
    if (value == 1) {
      messageSuccess(context, pesan);
      Navigator.pop(context);
    } else if (value == 2) {
      messageInfo(context, pesan);
    } else {
      messageDanger(context, pesan);
    }
  }

  void _cekForm() {
    final form = _keyForm.currentState;
    if (form.validate() && _validNohp()) {
      form.save();
      _register();
    } else {
      if (!_validNohp()) {
        messageInfo(context, "Nohp tidak valid");
      }
    }
  }

  bool _validNohp() {
    if (_tecNohp.text.length > 10 && _tecNohp.text.length < 15) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colPrimary,
      body: SafeArea(
        child: Container(
          height: mediaSize.height,
          width: mediaSize.width,
          color: colSecondary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  color: colPrimary,
                  child: Center(
                    child: Text(
                      "Register Movie App",
                      style: GoogleFonts.mcLaren(
                        color: colSecondary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        color: colPrimary,
                        height: mediaSize.height,
                      ),
                      Container(
                        height: mediaSize.height,
                        padding: EdgeInsets.only(top: 80, left: 20),
                        margin: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                            ),
                            color: colSecondary),
                        child: Form(
                          key: _keyForm,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Input Email';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _tecEmail,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Input Password';
                                  }
                                  return null;
                                },
                                controller: _tecPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Input Nama Lengkap';
                                  }
                                  return null;
                                },
                                controller: _tecNama,
                                decoration: InputDecoration(
                                  hintText: "Nama Lengkap",
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Input No. Handphone';
                                  }
                                  return null;
                                },
                                controller: _tecNohp,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "No. handphone",
                                  prefixIcon: Icon(Icons.call),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Input Alamat';
                                  }
                                  return null;
                                },
                                controller: _tecAlamat,
                                minLines: 1,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: "Alamat",
                                  prefixIcon: Icon(Icons.home),
                                ),
                              ),
                              SizedBox(height: 40),
                              MaterialButton(
                                minWidth: 200,
                                height: 60,
                                color: colPrimary,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () => _cekForm(),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: colSecondary, fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 60),
                            ],
                          ),
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
