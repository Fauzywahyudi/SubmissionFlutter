import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/utils/assets/color.dart';
import 'package:form_login_register_mahasiswa/views/login.dart';

class Home extends StatefulWidget {
  final data;

  const Home({Key key, this.data}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var asset = "assets/images/";

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _logout(),
        icon: Icon(Icons.exit_to_app),
        tooltip: "Logout",
        label: Text("Logout"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.data['nama_lengkap'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colPrimary,
                      colInfo,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colSecondary,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(asset + "foto.jpg"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.data['nim_mahasiswa']),
                  subtitle: Text("NIM Mahasiswa"),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text(widget.data['jenis_kelamin']),
                  subtitle: Text("Jenis Kelamin"),
                  leading: Icon(Icons.wc),
                ),
                ListTile(
                  title: Text(widget.data['jurusan']),
                  subtitle: Text("Jurusan"),
                  leading: Icon(Icons.school),
                ),
                ListTile(
                  title: Text(widget.data['alamat']),
                  subtitle: Text("Alamat"),
                  leading: Icon(Icons.home),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
