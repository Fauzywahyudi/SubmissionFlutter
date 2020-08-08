import 'package:cek_login_sederhana_flutter/views/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final username;

  const Home({Key key, this.username}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _logout(),
        label: Text("Logout"),
        icon: Icon(Icons.exit_to_app),
      ),
      body: Container(
        child: Center(
          child: Text(
              "Selamat Datang ${widget.username.toString().toUpperCase()}"),
        ),
      ),
    );
  }

  void _logout() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
}
