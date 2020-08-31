import 'dart:async';
import 'dart:convert';
import 'package:aplikasi_notes/models/shared_preferenced.dart';
import 'package:aplikasi_notes/providers/notes_provider.dart';
import 'package:aplikasi_notes/views/add_notes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_notes/models/user.dart';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:aplikasi_notes/utils/custom_path.dart';
import 'package:aplikasi_notes/views/register.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_notes/utils/link.dart' as link;

enum StatusLogin { signIn, notSignIn }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var tecUsername = TextEditingController();
  var tecPassword = TextEditingController();
  var focuUsername = FocusNode();
  var focPassword = FocusNode();
  User _user;
  DataShared _dataShared = DataShared();
  NotesProvider _notesProvider = NotesProvider();
  List _dataNotes;

  StatusLogin _statusLogin = StatusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();

  void _login() async {
    final result = await http.post(link.Link.server + "login.php", body: {
      "username": tecUsername.text,
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
        tecUsername.text = "";
        tecPassword.text = "";
      });
    } else if (value == 2) {
      messageInfo(context, pesan);
    } else {
      messageInfo(context, pesan + "\nUsername atau Password Salah!");
    }
  }

  Future _logout() async {
    await _dataShared.logout();
    setState(() {
      _statusLogin = StatusLogin.notSignIn;
    });
  }

  void _cekForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      _login();
    }
  }

  void _tapRegister() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      );

  void _tapAddNotes() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNotes(), fullscreenDialog: true));

  Future _saveDataPref(int value, User user) async {
    await _dataShared.saveDataPref(value, user);
  }

  Future _getValuePref() async {
    final value = await _dataShared.getValue();
    if (value == 1) {
      _statusLogin = StatusLogin.signIn;
      _user = await _dataShared.getDataPref();
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

  void _dialogLogout() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Logout',
      desc: 'Yakin untuk Logout',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _logout();
      },
    )..show();
  }

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

  Future<List> _getAllNotes() async {
    final result = await _notesProvider.getAllNotes(context, _user.getId());
    return result;
  }

  @override
  void initState() {
    _getValuePref();
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
    }
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _tapAddNotes(),
      ),
      body: SafeArea(
        child: Container(
          color: colSecondary,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerViewIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () => _dialogLogout(),
                    ),
                  ],
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Notes App"),
                    centerTitle: true,
                    background: Container(
                      decoration: BoxDecoration(color: colPrimary),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder<List>(
                future: _getAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? RefreshIndicator(
                          onRefresh: handleRefresh,
                          child: GridView.builder(
                              itemCount: snapshot.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200.0,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1.3,
                              ),
                              itemBuilder: (context, index) {
                                return _buildItemGrid(snapshot.data[index]);
                              }),
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogin(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
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
      ),
    );
  }

  Widget _buildFormInput() {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          buildTextField(
            context: context,
            hint: "Username",
            controller: tecUsername,
            focus: focuUsername,
            nextFocus: focPassword,
            icon: Icons.person,
          ),
          buildTextField(
            context: context,
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

  Widget _buildItemGrid(var data) {
    return InkWell(
      onTap: () {},
      child: Hero(
        tag: data['id_notes'],
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: colPrimary,
            ),
            child: Center(
              child: AutoSizeText(
                data['judul_notes'],
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 20, color: colSecondary),
                maxLines: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
