import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/repository/shared_preferenced.dart';
// import 'package:movie_app/models/status_login.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/views/home.dart';
import 'package:movie_app/views/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DataShared _dataShared = DataShared();
  bool _isLoading = true;

  Future _getValuePref() async {
    final value = await _dataShared.getValue();
    if (value == 1) {
      pushReplacePage(context, HomePage());
    }
    setState(() {
      _isLoading = false;
    });
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
      backgroundColor: colPrimary,
      body: _isLoading ? LoadingWidget() : FormLogin(context),
    );
  }
}

class FormLogin extends StatefulWidget {
  final BuildContext context;
  FormLogin(this.context);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _keyForm = GlobalKey<FormState>();

  var _tecUsername = TextEditingController();

  var _tecPassword = TextEditingController();

  Future _dialogExit() async {
    AwesomeDialog(
      context: widget.context,
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
    var mediaSize = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: mediaSize.height,
          width: mediaSize.width,
          color: colSecondary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  color: colPrimary,
                  child: Center(
                    child: Text(
                      "Login",
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
                        height: mediaSize.height - 250,
                      ),
                      Container(
                        height: mediaSize.height - 200,
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
                                controller: _tecUsername,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _tecPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock),
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
                                onPressed: () {},
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: colSecondary, fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 60),
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
