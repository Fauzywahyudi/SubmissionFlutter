import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:aplikasi_notes/models/user.dart';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:aplikasi_notes/utils/custom_path.dart';
import 'package:aplikasi_notes/views/home.dart';
import 'package:aplikasi_notes/views/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_notes/utils/link.dart' as link;
import 'package:shared_preferences/shared_preferences.dart';

enum StatusLogin { signIn, notSignIn }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var tecNIM = TextEditingController();
  var tecPassword = TextEditingController();
  var focNIM = FocusNode();
  var focPassword = FocusNode();
  bool isLoading = true;
  User _user;

  StatusLogin _statusLogin = StatusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();

  void _login() async {
    final result = await http.post(link.Link.server + "login.php", body: {
      "username": tecNIM.text,
      "password": tecPassword.text,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    print(pesan);

    if (value == 1) {
      final data = await json.decode(response['data']);
      _user = User(int.parse(data['id_user']), data['username'],
          data['nama_lengkap'], data['jenis_kelamin'], data['tgl_daftar']);
      setState(() {
        _statusLogin = StatusLogin.signIn;
        _saveDataPref(value, _user);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Home(
        //       user: _user,
        //     ),
        //   ),
        // );
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  void _cekForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      _login();
    }
  }

  void _tapRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Register(),
      ),
    );
  }

  void _saveDataPref(int value, User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setInt("id", user.getId());
      sharedPreferences.setString("username", user.getUsername());
      sharedPreferences.setString("nama", user.getNama());
      sharedPreferences.setString("jk", user.getJk());
      sharedPreferences.setString("tgl_daftar", user.getTglDaftar());
    });
  }

  void _getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      User user;
      int nValue = sharedPreferences.getInt("value");
      if (nValue == 1) {
        int id = sharedPreferences.getInt("id");
        String username = sharedPreferences.getString("username");
        String nama = sharedPreferences.getString("nama");
        String jk = sharedPreferences.getString("jk");
        String tglDaftar = sharedPreferences.getString("tgl_daftar");

        user = User(id, username, nama, jk, tglDaftar);
        setState(() {
          _statusLogin = StatusLogin.signIn;
        });
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Home(
        //       user: user,
        //     ),
        //   ),
        // );
      }
    });
  }

  @override
  void initState() {
    _getDataPref();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_statusLogin) {
      case StatusLogin.notSignIn:
        return _buildLogin(context);
        break;
      case StatusLogin.signIn:
        return _buildHome(context);
        break;
      default:
    }
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(),
    );
  }

  Widget _buildLogin(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: colSecondary,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomClip(),
                  Text(
                    "Login",
                    style: GoogleFonts.mcLaren(
                      color: colPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildFormInput(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No have account? "),
                      InkWell(
                        onTap: () => _tapRegister(),
                        child: Text(
                          "create here!",
                          style: GoogleFonts.mcLaren(
                            color: colPrimary,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormInput() {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          _buildTextField(
            hint: "Username",
            controller: tecNIM,
            focus: focNIM,
            nextFocus: focPassword,
            icon: Icons.person,
          ),
          _buildTextField(
            hint: "Password",
            controller: tecPassword,
            focus: focPassword,
            icon: Icons.lock,
            obscure: true,
          ),
          SizedBox(height: 20),
          _buildButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    String hint,
    TextEditingController controller,
    FocusNode focus,
    FocusNode nextFocus,
    bool obscure = false,
    int minLines = 1,
    TextInputType inputType = TextInputType.text,
    TextInputAction inputAction = TextInputAction.next,
    IconData icon = Icons.text_fields,
    TextCapitalization textCapital = TextCapitalization.none,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: colPrimary,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focus,
        style: textLabel,
        obscureText: obscure,
        keyboardType: inputType,
        textInputAction: inputAction,
        minLines: minLines,
        maxLines: minLines,
        textCapitalization: textCapital,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          hintText: hint,
        ),
        onEditingComplete: () {
          if (nextFocus == null) {
            focus.unfocus();
          } else {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Input $hint';
          }
          return null;
        },
      ),
    );
  }

  Center _buildButton() {
    return Center(
      child: InkWell(
        onTap: () {
          _cekForm();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colPrimary, width: 2),
          ),
          child: Text(
            "Login",
            style: GoogleFonts.mcLaren(
                color: colPrimary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
