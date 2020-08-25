import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/models/mahasiswa.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';
import 'package:form_login_register_mahasiswa/utils/custom_path.dart';
import 'package:form_login_register_mahasiswa/views/home.dart';
import 'package:form_login_register_mahasiswa/views/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:form_login_register_mahasiswa/utils/link.dart' as link;
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

  Mahasiswa _mahasiswa;

  StatusLogin _statusLogin = StatusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();

  void _login() async {
    final result = await http.post(link.Link.main + "login.php", body: {
      "nim": tecNIM.text,
      "pass": tecPassword.text,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    print(pesan);

    if (value == 1) {
      final data = await json.decode(response['data']);
      _mahasiswa = Mahasiswa(
        int.parse(data['id_mahasiswa']),
        data['nim_mahasiswa'],
        data['password'],
        data['nama_lengkap'],
        data['jenis_kelamin'],
        data['jurusan'],
        data['alamat'],
        data['tgl_daftar'],
      );
      setState(() {
        _statusLogin = StatusLogin.signIn;
      });
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

  void _saveDataPref(int value, Mahasiswa mahasiswa) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setInt("id", mahasiswa.getId());
      sharedPreferences.setString("nim", mahasiswa.getNim());
      sharedPreferences.setString("password", mahasiswa.getPass());
      sharedPreferences.setString("nama", mahasiswa.getNama());
      sharedPreferences.setString("jk", mahasiswa.getJK());
      sharedPreferences.setString("jurusan", mahasiswa.getJurusan());
      sharedPreferences.setString("alamat", mahasiswa.getAlamat());
      sharedPreferences.setString("tgl_daftar", mahasiswa.getTglDaftar());
    });
  }

  @override
  Widget build(BuildContext context) {
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
            hint: "NIM",
            controller: tecNIM,
            focus: focNIM,
            nextFocus: focPassword,
            inputType: TextInputType.number,
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
    bool obscure,
    int minLines,
    TextInputType inputType,
    TextInputAction inputAction,
    IconData icon,
    TextCapitalization textCapital,
  }) {
    bool _obscure = obscure;
    TextInputType _inputType = inputType;
    TextInputAction _inputAction = inputAction;
    IconData _icon = icon;
    int _minLines = minLines;
    TextCapitalization _textCapital = textCapital;

    if (obscure == null) _obscure = false;
    if (inputType == null) _inputType = TextInputType.text;
    if (inputAction == null) _inputAction = TextInputAction.next;
    if (icon == null) _icon = Icons.text_fields;
    if (minLines == null) _minLines = 1;
    if (textCapital == null) _textCapital = TextCapitalization.none;

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
        obscureText: _obscure,
        keyboardType: _inputType,
        textInputAction: _inputAction,
        minLines: _minLines,
        maxLines: _minLines,
        textCapitalization: _textCapital,
        decoration: InputDecoration(
          prefixIcon: Icon(_icon),
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
