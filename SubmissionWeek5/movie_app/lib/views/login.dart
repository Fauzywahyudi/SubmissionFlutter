import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/repository/shared_preferenced.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/views/home.dart';
import 'package:movie_app/views/register.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/link.dart' as link;

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

  var _tecEmail = TextEditingController();

  var _tecPassword = TextEditingController();

  bool _validEmail() {
    if (_tecEmail.text.contains(" ")) return false;
    if (_tecEmail.text.contains("@")) return true;
    return false;
  }

  void _cekForm() {
    final form = _keyForm.currentState;
    if (form.validate() && _validEmail()) {
      form.save();
      _login();
    } else {
      if (!_validEmail()) {
        messageInfo(context, "Email tidak valid");
      }
    }
  }

  void _login() async {
    final result = await http.post(link.Link.server + "login.php", body: {
      "email": _tecEmail.text,
      "password": _tecPassword.text,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    print(pesan);

    if (value == 1) {
      final data = await json.decode(response['data']);
      User _user = User(int.parse(data['id_user']), data['email'], data['nama'],
          data['nohp'], data['alamat'], data['tgl_daftar']);
      setState(() {
        _saveDataPref(value, _user);
        pushReplacePage(context, HomePage());
      });
    } else if (value == 2) {
      messageInfo(context, pesan);
    } else {
      messageInfo(context, pesan + "\nUsername atau Password Salah!");
    }
  }

  Future _saveDataPref(int value, User user) async {
    DataShared _dataShared = DataShared();
    await _dataShared.saveDataPref(value, user);
  }

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
                      "Login Movie App",
                      textAlign: TextAlign.center,
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
                        height: mediaSize.height - 250,
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
                                controller: _tecEmail,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email),
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
                                onPressed: () => _cekForm(),
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
