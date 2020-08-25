import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';
import 'package:form_login_register_mahasiswa/utils/custom_path.dart';
import 'package:form_login_register_mahasiswa/views/home.dart';
import 'package:form_login_register_mahasiswa/views/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:form_login_register_mahasiswa/utils/link.dart' as link;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var tecNIM = TextEditingController();
  var tecPassword = TextEditingController();
  var focNIM = FocusNode();
  var focPassword = FocusNode();

  void _login() async {
    final response = await http.post(link.Link.main + "login.php", body: {
      "nim": tecNIM.text,
      "pass": tecPassword.text,
    });
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            data: data[0],
          ),
        ),
      );
    }
    // messageStatus(context, response.statusCode);
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

  void _tapRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Register(),
      ),
    );
  }

  Widget _buildFormInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
      child: TextField(
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
        onSubmitted: (v) {
          if (nextFocus == null) {
            focus.unfocus();
          } else {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
      ),
    );
  }

  Center _buildButton() {
    return Center(
      child: InkWell(
        onTap: () => _login(),
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

class FormInput extends StatelessWidget {
  const FormInput({
    Key key,
    @required this.tecNIM,
    @required this.focNIM,
    @required this.focPassword,
    @required this.tecPassword,
  }) : super(key: key);

  final TextEditingController tecNIM;
  final FocusNode focNIM;
  final FocusNode focPassword;
  final TextEditingController tecPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: colPrimary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: tecNIM,
            focusNode: focNIM,
            style: textPrimary,
            textInputAction: TextInputAction.next,
            onSubmitted: (v) {
              FocusScope.of(context).requestFocus(focPassword);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              border: InputBorder.none,
              hintText: "NIM",
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: colPrimary, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: tecPassword,
            focusNode: focPassword,
            style: textPrimary,
            textInputAction: TextInputAction.done,
            obscureText: true,
            onSubmitted: (v) {
              focPassword.unfocus();
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                prefixIcon: Icon(Icons.lock)),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
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
      ],
    );
  }
}
