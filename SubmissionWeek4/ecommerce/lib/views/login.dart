import 'dart:async';
import 'dart:convert';
import 'package:ecommerce/models/shared_preferenced.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/providers/kategori_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/utils/custom_path.dart';
import 'package:ecommerce/views/register.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/utils/link.dart' as link;

enum StatusLogin { signIn, notSignIn }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _tecEmail = TextEditingController();
  var _tecPassword = TextEditingController();
  var _focuEmail = FocusNode();
  var _focPassword = FocusNode();
  User _user;
  DataShared _dataShared = DataShared();
  // NotesProvider _notesProvider = NotesProvider();
  KategoriProvider _kategoriProvider = KategoriProvider();
  StatusLogin _statusLogin = StatusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();

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
      _user = User(int.parse(data['id_user']), data['email'], data['nama'],
          data['nohp'], data['alamat'], data['tgl_daftar']);
      setState(() {
        _statusLogin = StatusLogin.signIn;
        _saveDataPref(value, _user);
        _tecEmail.text = "";
        _tecPassword.text = "";
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
    if (form.validate() && _validEmail()) {
      form.save();
      _login();
    } else {
      if (!_validEmail()) {
        messageInfo(context, "Email tidak valid");
      }
    }
  }

  bool _validEmail() {
    if (_tecEmail.text.contains(" ")) return false;
    if (_tecEmail.text.contains("@")) return true;
    return false;
  }

  void _tapRegister() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      );

  void _tapAddNotes() async {
    // await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => AddNotes(), fullscreenDialog: true));
    handleRefresh();
  }

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

  void _dialogHapus(int id) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Hapus',
      desc: 'Yakin untuk hapus notes?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // _notesProvider.deleteNotes(context, id);
        handleRefresh();
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

  Future<List> _getKategori() async {
    final result = await _kategoriProvider.getAllKategori(context);
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
        child: WillPopScope(
          onWillPop: _onWillPop,
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
                    expandedHeight: 200,
                    flexibleSpace: _buildFlexibleSpaceBar(),
                  ),
                ];
              },
              body: Container(
                padding: EdgeInsets.all(10),
                child: FutureBuilder<List>(
                  future: _getKategori(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? GridView.builder(
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200.0,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1.3,
                            ),
                            itemBuilder: (context, index) {
                              return _buildItemGrid(snapshot.data[index]);
                            })
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FlexibleSpaceBar _buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      title: Text("Ecommerce App"),
      centerTitle: true,
      background: Container(
        decoration: BoxDecoration(color: colPrimary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 15),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(2),
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colSecondary,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Hero(
                          tag: 'foto',
                          child: Image.asset(link.Link.asset + "foto.jpg")),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  _user.getNama(),
                  style: GoogleFonts.mcLaren(color: colSecondary, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            )
          ],
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
                    CustomClip(height: 300.0),
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
            hint: "Email",
            controller: _tecEmail,
            focus: _focuEmail,
            nextFocus: _focPassword,
            icon: Icons.person,
          ),
          buildTextField(
            context: context,
            hint: "Password",
            controller: _tecPassword,
            focus: _focPassword,
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
      onTap: () async {
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailNotes(
        //       data: data,
        //     ),
        //   ),
        // );
        handleRefresh();
      },
      child: Hero(
        tag: data['id_notes'],
        child: Card(
          key: ValueKey(data['id_notes']),
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
            child: Stack(
              children: [
                Positioned(
                  top: -15,
                  right: -10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {},
                        iconSize: 20,
                        color: colSecondary,
                        icon: new PopupMenuButton(
                          tooltip: "More",
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            new PopupMenuItem<String>(
                                child: ListTile(
                                    title: Text('Hapus'),
                                    trailing: Icon(
                                      Icons.delete,
                                      color: colDanger,
                                    )),
                                value: 'hapus'),
                            new PopupMenuItem<String>(
                                child: ListTile(
                                    title: Text('Edit'),
                                    trailing: Icon(
                                      Icons.edit,
                                      color: colSuccess,
                                    )),
                                value: 'edit'),
                          ],
                          onSelected: (v) async {
                            if (v == "hapus") {
                              _dialogHapus(int.parse(data['id_notes']));
                            } else if (v == "edit") {
                              // await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EditNotes(
                              //               data: data,
                              //             )));
                              handleRefresh();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: AutoSizeText(
                    data['judul_notes'],
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.mcLaren(fontSize: 23, color: colSecondary),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _noNotif() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.height / 4,
              child: Image.asset(
                link.Link.asset + "nodata.png",
                fit: BoxFit.cover,
              )),
          Container(
            child: Text(
              "Tidak Ada Notes",
              style: TextStyle(color: Colors.grey, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
