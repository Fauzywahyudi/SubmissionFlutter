import 'dart:async';

import 'package:aplikasi_wisata/models/wisata.dart';
import 'package:aplikasi_wisata/views/add_wisata.dart';
import 'package:aplikasi_wisata/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  DatabaseReference _wisataRef;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Wisata> _listWisata = List();

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  StreamSubscription<Event> _onSekolahAddedSubcription;
  StreamSubscription<Event> _onSekolahChangedSubcription;

  @override
  void initState() {
    super.initState();
    _wisataRef = _database.reference().child("wisata");
    _onSekolahAddedSubcription = _wisataRef.onChildAdded.listen(_onNewSekolah);
    _onSekolahChangedSubcription =
        _wisataRef.onChildChanged.listen(_onChangedSekolah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(),
      drawer: _buildDrawer(),
      body: _buildList(),
    );
  }

  Container _buildList() {
    return Container(
      child: ListView.builder(
        itemCount: _listWisata.length,
        itemBuilder: (context, index) {
          Wisata wisata = _listWisata[index];
          return Card(
            child: Dismissible(
              key: Key(wisata.key),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) async {
                _deleteWisata(wisata.key, index, wisata.urlImage);
              },
              child: ListTile(
                // onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => MapPage(
                //               sekolah: sekolah,
                //             ))),
                title: Text(
                  wisata.nama,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                subtitle: Text(wisata.deskripsi),
                leading: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  // onPressed: () => _editState(wisata),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Home'),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => onClickFab(),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: Colors.blue,
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: () => _signOut(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void onClickFab() {
    Navigator.pushNamed(context, AddWisata.routeName);
  }

  void _onNewSekolah(Event event) {
    setState(() {
      _listWisata.add(Wisata.fromSnapshot(event.snapshot));
    });
  }

  void _onChangedSekolah(Event event) {
    var oldEntry = _listWisata.singleWhere((sekolah) {
      return sekolah.key == event.snapshot.key;
    });
    setState(() {
      _listWisata[_listWisata.indexOf(oldEntry)] =
          Wisata.fromSnapshot(event.snapshot);
    });
  }

  Future<void> _deleteWisata(String key, int index, String url) async {
    await _wisataRef.child(key).remove();
    _listWisata.removeAt(index);
    StorageReference ref = await firebaseStorage.getReferenceFromUrl(url);
    await ref.delete();
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text('Berhasil dihapus'),
    ));
    setState(() {});
  }
}
