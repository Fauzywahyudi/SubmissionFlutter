import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';
import 'package:form_login_register_mahasiswa/utils/custom_path.dart';
import 'package:form_login_register_mahasiswa/views/register.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var tecNIM = TextEditingController();
  var tecPassword = TextEditingController();
  var focNIM = FocusNode();
  var focPassword = FocusNode();

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
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormInput(
                      tecNIM: tecNIM,
                      focNIM: focNIM,
                      focPassword: focPassword,
                      tecPassword: tecPassword),
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
