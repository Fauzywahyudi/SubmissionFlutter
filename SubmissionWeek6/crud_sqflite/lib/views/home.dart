import 'dart:async';
import 'package:crud_sqflite/models/model_user.dart';
import 'package:crud_sqflite/sqflite/db_helper.dart';
import 'package:crud_sqflite/utils/assets.dart';
import 'package:crud_sqflite/views/add_mahasiswa.dart';
import 'package:crud_sqflite/views/detail_mahasiswa.dart';
import 'package:crud_sqflite/views/edit_mahasiswa.dart';
import 'package:crud_sqflite/views/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/Homepage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _logout() async {
    DatabaseHelper db = DatabaseHelper();
    ModelUser user = await db.getOnline();
    await db
        .getLogout(user)
        .then((_) => Navigator.pushReplacementNamed(context, Login.routeName));
  }

  Future<List> _getAllMahasiswa() async {
    DatabaseHelper db = DatabaseHelper();
    List listData = await db.getAllMahasiswa();
    return listData;
  }

  Future _deleteMahasiswa(int id) async {
    DatabaseHelper db = DatabaseHelper();
    await db.deleteMahasiswa(id).then((value) {
      if (value == 1) {
        messageSuccess("Berhasil dihapus");
      } else {
        messageFailed("Gagal dihapus");
      }
    });
    handleRefresh();
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, TambahMahasiswa.routeName);
          handleRefresh();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      drawer: _buildDrawer(),
      body: Container(
        child: FutureBuilder<List>(
          future: _getAllMahasiswa(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? _buildListBuilder(snapshot) : _loading();
          },
        ),
      ),
    );
  }

  Widget _buildListBuilder(AsyncSnapshot<List> snapshot) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            key: ValueKey(snapshot.data[index]['id']),
            leading: Icon(Icons.person),
            title: Text(snapshot.data[index]['nama']),
            subtitle: Text("NIM : " + snapshot.data[index]['nim']),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      onPressed: () async {
                        await pushPage(context,
                            DetailMahasiswa(data: snapshot.data[index]));
                        handleRefresh();
                      },
                      child: Text("Lihat")),
                  FlatButton(
                      onPressed: () =>
                          _deleteMahasiswa(snapshot.data[index]['id']),
                      child: Text("Hapus")),
                  FlatButton(
                      onPressed: () async {
                        await pushPage(
                            context,
                            EditMahasiswa(
                              data: snapshot.data[index],
                            ));
                        handleRefresh();
                      },
                      child: Text("Edit")),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Center _loading() => Center(child: CircularProgressIndicator());

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
                color: Colors.blue,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                )),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
              onTap: () => _logout(),
            ),
          ],
        ),
      ),
    );
  }
}
