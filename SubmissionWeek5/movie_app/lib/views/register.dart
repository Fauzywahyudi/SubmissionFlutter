import 'dart:convert';
import 'package:flutter/material.dart';
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

  var _focEmail = FocusNode();
  var _focPassword = FocusNode();
  var _focNama = FocusNode();
  var _focNohp = FocusNode();
  var _focAlamat = FocusNode();

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
    if (form.validate() && _validEmail() && _validNohp()) {
      form.save();
      _register();
    } else {
      if (!_validEmail()) {
        messageInfo(context, "Email tidak valid");
      } else if (!_validNohp()) {
        messageInfo(context, "Nohp tidak valid");
      }
    }
  }

  bool _validEmail() {
    if (_tecEmail.text.contains(" ")) return false;
    if (_tecEmail.text.contains("@")) return true;
    return false;
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
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CustomClip(
                  //   height: 200,
                  // ),
                  SizedBox(height: 200),
                  Text(
                    "Register",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buildTextField(
          //   context: context,
          //   hint: "Email",
          //   controller: _tecEmail,
          //   focus: _focEmail,
          //   nextFocus: _focPassword,
          //   inputType: TextInputType.emailAddress,
          //   icon: Icons.person,
          // ),
          // buildTextField(
          //   context: context,
          //   hint: "Password",
          //   controller: _tecPassword,
          //   focus: _focPassword,
          //   nextFocus: _focNama,
          //   icon: Icons.lock,
          //   obscure: true,
          // ),
          // buildTextField(
          //   context: context,
          //   hint: "Nama Lengkap",
          //   controller: _tecNama,
          //   focus: _focNama,
          //   nextFocus: _focNohp,
          //   icon: Icons.person,
          //   textCapital: TextCapitalization.words,
          // ),
          // buildTextField(
          //   context: context,
          //   hint: "No. HP",
          //   controller: _tecNohp,
          //   focus: _focNohp,
          //   nextFocus: _focAlamat,
          //   icon: Icons.call,
          //   inputType: TextInputType.phone,
          // ),
          // buildTextField(
          //   context: context,
          //   hint: "Alamat",
          //   controller: _tecAlamat,
          //   focus: _focAlamat,
          //   icon: Icons.home,
          //   textCapital: TextCapitalization.words,
          // ),
          SizedBox(height: 20),
          _buildButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Center _buildButton() {
    return Center(
      child: InkWell(
        onTap: () => _cekForm(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colPrimary, width: 2),
          ),
          child: Text(
            "Register",
            style: GoogleFonts.mcLaren(
                color: colPrimary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
