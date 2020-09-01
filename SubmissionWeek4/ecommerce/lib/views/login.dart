import 'dart:async';
import 'package:ecommerce/models/shared_preferenced.dart';
import 'package:ecommerce/models/status_login.dart';
import 'package:ecommerce/views/build_home.dart';
import 'package:ecommerce/views/build_login.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // var _tecEmail = TextEditingController();
  // var _tecPassword = TextEditingController();
  // var _focuEmail = FocusNode();
  // var _focPassword = FocusNode();
  User _user;
  DataShared _dataShared = DataShared();
  // NotesProvider _notesProvider = NotesProvider();
  // KategoriProvider _kategoriProvider = KategoriProvider();
  StatusLogin _statusLogin = StatusLogin.notSignIn;
  // final _keyForm = GlobalKey<FormState>();

  // void _login() async {
  //   final result = await http.post(link.Link.server + "login.php", body: {
  //     "email": _tecEmail.text,
  //     "password": _tecPassword.text,
  //   });
  //   final response = await json.decode(result.body);
  //   int value = response['value'];
  //   String pesan = response['message'];
  //   print(pesan);

  //   if (value == 1) {
  //     final data = await json.decode(response['data']);
  //     _user = User(int.parse(data['id_user']), data['email'], data['nama'],
  //         data['nohp'], data['alamat'], data['tgl_daftar']);
  //     setState(() {
  //       _statusLogin = StatusLogin.signIn;
  //       _saveDataPref(value, _user);
  //       _tecEmail.text = "";
  //       _tecPassword.text = "";
  //     });
  //   } else if (value == 2) {
  //     messageInfo(context, pesan);
  //   } else {
  //     messageInfo(context, pesan + "\nUsername atau Password Salah!");
  //   }
  // }

  // Future _logout() async {
  //   await _dataShared.logout();
  //   setState(() {
  //     _statusLogin = StatusLogin.notSignIn;
  //   });
  // }

  // void _cekForm() {
  //   final form = _keyForm.currentState;
  //   if (form.validate() && _validEmail()) {
  //     form.save();
  //     _login();
  //   } else {
  //     if (!_validEmail()) {
  //       messageInfo(context, "Email tidak valid");
  //     }
  //   }
  // }

  // bool _validEmail() {
  //   if (_tecEmail.text.contains(" ")) return false;
  //   if (_tecEmail.text.contains("@")) return true;
  //   return false;
  // }

  // void _tapRegister() => pushPage(context, Register());

  // Future _saveDataPref(int value, User user) async {
  //   await _dataShared.saveDataPref(value, user);
  // }

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

  // void _dialogLogout() async {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.INFO,
  //     animType: AnimType.BOTTOMSLIDE,
  //     title: 'Logout',
  //     desc: 'Yakin untuk Logout',
  //     btnCancelOnPress: () {},
  //     btnOkOnPress: () {
  //       _logout();
  //     },
  //   )..show();
  // }

  // void _dialogHapus(int id) async {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.WARNING,
  //     animType: AnimType.BOTTOMSLIDE,
  //     title: 'Hapus',
  //     desc: 'Yakin untuk hapus notes?',
  //     btnCancelOnPress: () {},
  //     btnOkOnPress: () {
  //       // _notesProvider.deleteNotes(context, id);
  //       handleRefresh();
  //     },
  //   )..show();
  // }

  // Future _dialogExit() async {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.INFO,
  //     animType: AnimType.BOTTOMSLIDE,
  //     title: 'Exit',
  //     desc: 'Yakin Keluar Aplikasi',
  //     btnCancelOnPress: () {},
  //     btnOkOnPress: () {
  //       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //     },
  //   )..show();
  // }

  // Future<bool> _onWillPop() async {
  //   return _dialogExit();
  // }

  // Future<List> _getKategori() async {
  //   final result = await _kategoriProvider.getAllKategori(context);
  //   return result;
  // }

  @override
  void initState() {
    _getValuePref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_statusLogin) {
      case StatusLogin.notSignIn:
        return BuildLogin();
        break;
      case StatusLogin.signIn:
        return BuildHome(
          user: _user,
        );
        break;
    }
  }
}
