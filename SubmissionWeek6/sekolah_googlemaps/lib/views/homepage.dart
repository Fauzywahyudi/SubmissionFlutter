import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sekolah_googlemaps/models/sekolah_model.dart';
import 'package:sekolah_googlemaps/views/login.dart';
import 'package:sekolah_googlemaps/views/map_page.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseUser user;

  const MyHomePage({Key key, this.user}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onSekolahAddedSubcription;
  StreamSubscription<Event> _onSekolahChangedSubcription;
  DatabaseReference _sekolahRef;
  FToast fToast;
  SekolahModel _editModel;

  var _tecNamaSekolah = TextEditingController();
  var _tecDetailSekolah = TextEditingController();
  var _tecLong = TextEditingController();
  var _tecLat = TextEditingController();

  String _page = "Home";

  List<SekolahModel> _listSekolah = List();

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    _sekolahRef = _database.reference().child("sekolah");
    _onSekolahAddedSubcription = _sekolahRef.onChildAdded.listen(_onNewSekolah);
    _onSekolahChangedSubcription =
        _sekolahRef.onChildChanged.listen(_onChangedSekolah);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _onSekolahAddedSubcription.cancel();
    _onSekolahChangedSubcription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(),
      drawer: _buildDrawer(),
      body: _showPage(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_page),
      actions: [
        _page == "Tambah Sekolah" || _page == "Edit Sekolah"
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(
                    () {
                      _page = "Home";
                      _clear();
                    },
                  );
                },
              )
            : Container(),
      ],
    );
  }

  Widget _showPage() {
    return _page == "Home"
        ? _buildList()
        : _page == "Tambah Sekolah" ? _buildAddData() : _buildEditData();
  }

  Container _buildList() {
    return Container(
      child: ListView.builder(
        itemCount: _listSekolah.length,
        itemBuilder: (context, index) {
          SekolahModel sekolah = _listSekolah[index];
          return Card(
            child: Dismissible(
              key: Key(sekolah.key),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) async {
                _deleteSekolah(sekolah.key, index);
              },
              child: ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(
                              sekolah: sekolah,
                            ))),
                title: Text(
                  sekolah.namaSekolah,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                subtitle: Text(sekolah.deskripsi),
                leading: Icon(
                  Icons.school,
                  color: Colors.blue,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  onPressed: () => _editState(sekolah),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _buildAddData() {
    return Container(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _tecNamaSekolah,
              decoration: InputDecoration(
                labelText: 'Nama Sekolah',
                prefixIcon: Icon(Icons.school),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tecDetailSekolah,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tecLat,
              decoration: InputDecoration(
                labelText: 'Latitude',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tecLong,
              decoration: InputDecoration(
                labelText: 'Longitude',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container _buildEditData() {
    return Container(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _tecNamaSekolah,
              decoration: InputDecoration(
                labelText: 'Nama Sekolah',
                prefixIcon: Icon(Icons.school),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tecDetailSekolah,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tecLong,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Longitute',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tecLat,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Latitud',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildFab() {
    if (_page == "Home") {
      return FloatingActionButton(
        onPressed: () {
          setState(() {
            _page = "Tambah Sekolah";
          });
        },
        child: Icon(Icons.add),
      );
    } else if (_page == "Tambah Sekolah") {
      return FloatingActionButton(
        onPressed: () => _addSekolah(_tecNamaSekolah.text,
            _tecDetailSekolah.text, _tecLong.text, _tecLat.text),
        child: Icon(Icons.check),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          _updateSekolah(_editModel);
        },
        child: Icon(Icons.check),
      );
    }
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.blue[300],
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 230,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  ClipOval(
                    child: Image.network(widget.user.photoUrl),
                  ),
                  SizedBox(width: 10),
                  Text(widget.user.displayName,
                      style: GoogleFonts.mcLaren(
                          fontSize: 18, color: Colors.white))
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.white,
              ),
              title: Text(
                widget.user.email,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                LineIcons.power_off,
                color: Colors.white,
              ),
              onTap: () => _signOut(),
              title: Text(
                "Logout",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onNewSekolah(Event event) {
    setState(() {
      _listSekolah.add(SekolahModel.fromSnapshot(event.snapshot));
    });
  }

  void _onChangedSekolah(Event event) {
    var oldEntry = _listSekolah.singleWhere((sekolah) {
      return sekolah.key == event.snapshot.key;
    });
    setState(() {
      _listSekolah[_listSekolah.indexOf(oldEntry)] =
          SekolahModel.fromSnapshot(event.snapshot);
    });
  }

  void _clear() {
    setState(() {
      _tecNamaSekolah.clear();
      _tecDetailSekolah.clear();
      _tecLong.clear();
      _tecLat.clear();
    });
  }

  bool _validasi() {
    if (_tecNamaSekolah.text.isEmpty) return false;
    if (_tecDetailSekolah.text.isEmpty) return false;
    if (_tecLong.text.isEmpty) return false;
    if (_tecLat.text.isEmpty) return false;
    return true;
  }

  Future<void> _addSekolah(
      String namaSekolah, String deskripsi, String long, String lat) async {
    if (_validasi()) {
      SekolahModel sekolah = SekolahModel(namaSekolah, deskripsi, long, lat);
      await _sekolahRef.push().set(sekolah.toJson());
      setState(() {
        _page = "Home";
        _clear();
        _showToastSuccess("Berhasil ditambahkan");
      });
    }
  }

  Future<void> _deleteSekolah(String key, int index) async {
    await _sekolahRef.child(key).remove();
    _listSekolah.removeAt(index);
    _showToastSuccess("Berhasil dihapus");
  }

  void _editState(SekolahModel sekolah) {
    setState(() {
      _page = "Edit Sekolah";
      _tecNamaSekolah.text = sekolah.namaSekolah;
      _tecDetailSekolah.text = sekolah.deskripsi;
      _tecLong.text = sekolah.long;
      _tecLat.text = sekolah.lat;
      _editModel = sekolah;
    });
  }

  Future<void> _updateSekolah(SekolahModel sekolah) async {
    sekolah.namaSekolah = _tecNamaSekolah.text;
    sekolah.deskripsi = _tecDetailSekolah.text;
    sekolah.lat = _tecLat.text;
    sekolah.long = _tecLong.text;
    await _sekolahRef.child(sekolah.key).set(sekolah.toJson());
    setState(() {
      _page = "Home";
    });
    _clear();
    _showToastSuccess("Berhasil diupdate");
  }

  void _showToastSuccess(String pesan) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(pesan),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
