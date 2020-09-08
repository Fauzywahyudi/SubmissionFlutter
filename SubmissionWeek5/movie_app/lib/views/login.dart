import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/repository/shared_preferenced.dart';
// import 'package:movie_app/models/status_login.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:flutter/material.dart';
// import 'package:movie_app/models/user.dart';
import 'package:movie_app/views/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // User _user;
  DataShared _dataShared = DataShared();
  // StatusLogin _statusLogin = StatusLogin.notSignIn;
  bool _isLoading = true;

  Future _getValuePref() async {
    final value = await _dataShared.getValue();
    if (value == 1) {
      // _statusLogin = StatusLogin.signIn;
      // _user = await _dataShared.getDataPref();
    }
    setState(() {});
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  void initState() {
    _getValuePref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? LoadingWidget() : FormLogin(context),
    );
  }
}

class FormLogin extends StatelessWidget {
  final BuildContext context;
  FormLogin(this.context);

  final _keyForm = GlobalKey<FormState>();

  var _tecUsername = TextEditingController();
  var _tecPassword = TextEditingController();

  Future _dialogExit() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Exit',
      desc: 'Yakin Keluar Aplikasi',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    )..show();
  }

  Future<bool> _onWillPop() async {
    return _dialogExit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: colSecondary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CustomClip(height: 300.0),
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
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _tecUsername,
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      TextFormField(
                        controller: _tecPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 20),
                      // _buildButton(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No have account? "),
                    InkWell(
                      onTap: () => pushPage(context, Register()),
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
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
