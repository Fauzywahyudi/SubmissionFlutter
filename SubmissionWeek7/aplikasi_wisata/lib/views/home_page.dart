import 'package:aplikasi_wisata/views/add_wisata.dart';
import 'package:aplikasi_wisata/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(),
      drawer: _buildDrawer(),
      body: Container(),
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
}
