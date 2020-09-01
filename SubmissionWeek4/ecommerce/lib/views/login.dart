import 'dart:async';
import 'dart:convert';
import 'package:ecommerce/models/shared_preferenced.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/models/status_login.dart';
import 'package:ecommerce/providers/kategori_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/utils/custom_path.dart';
import 'package:ecommerce/views/register.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/utils/link.dart' as link;
import 'package:line_icons/line_icons.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Likes',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

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
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Kategori",
                      style: GoogleFonts.mcLaren(
                        color: colPrimary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  _listFutureBuilder(),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: colPrimary,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.heart_o,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: LineIcons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }

  Container _listFutureBuilder() {
    return Container(
      height: 160,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: FutureBuilder<List>(
        future: _getKategori(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return _buildItemGrid(snapshot.data[index]);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
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
        print(data['nama_kategori']);
      },
      child: Container(
        width: 100,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colPrimary,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  link.Link.imageKategori + data['icon_kategori'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AutoSizeText(
              data['nama_kategori'],
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren(fontSize: 15),
              maxLines: 2,
            )
          ],
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
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
