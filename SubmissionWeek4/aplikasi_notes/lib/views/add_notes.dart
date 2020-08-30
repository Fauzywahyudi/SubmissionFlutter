import 'package:aplikasi_notes/models/user.dart';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  int _idUser;

  void _getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _idUser = sharedPreferences.getInt("id");
    });
    print(_idUser);
  }

  @override
  void initState() {
    _getId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      appBar: AppBar(
        title: Text(
          "Tambah Notes",
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colSecondary,
        child: Icon(
          Icons.check,
          color: colPrimary,
        ),
      ),
      body: Container(),
    );
  }
}
