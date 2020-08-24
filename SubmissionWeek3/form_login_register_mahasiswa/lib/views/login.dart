import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';
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

  var asset = "assets/images/";
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
                  Stack(
                    children: [
                      ClipPath(
                        clipper: WaveClipperOne(),
                        child: Container(
                          color: colPrimary,
                          height: 200,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 175,
                        child: Hero(
                            tag: "logo",
                            child: SvgPicture.asset(asset + "logo.svg")),
                      ),
                    ],
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
