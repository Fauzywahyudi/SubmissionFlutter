import 'package:aplikasi_notes/models/shared_preferenced.dart';
import 'package:aplikasi_notes/models/user.dart';
import 'package:aplikasi_notes/providers/notes_provider.dart';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  User _user;
  DataShared _dataShared = DataShared();
  NotesProvider _notesProvider = NotesProvider();
  var _tecJudul = TextEditingController();
  var _tecIsi = TextEditingController();

  Future _getData() async {
    _user = await _dataShared.getDataPref();
  }

  void _addNotes() async {
    if (_tecJudul.text.isNotEmpty && _tecIsi.text.isNotEmpty) {
      int value = await _notesProvider.addNotes(
          context, _user.getId(), _tecJudul.text, _tecIsi.text);
      if (value == 1) Navigator.pop(context);
    } else {
      messageInfo(context, "Harap isi semua data!");
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: colSecondary,
        ),
        child: Stack(
          children: [
            Container(
              color: colPrimary,
              height: 150,
            ),
            _buildTitleNotes(),
            _buildContentNotes(),
          ],
        ),
      ),
    );
  }

  Padding _buildContentNotes() {
    return Padding(
      padding: EdgeInsets.only(top: 170, left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            color: colPrimary,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Notes Content",
                    style:
                        GoogleFonts.mcLaren(fontSize: 17, color: colSecondary),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    controller: _tecIsi,
                    style: textSecondary,
                    minLines: 8,
                    maxLines: 16,
                    decoration: InputDecoration(
                      hintText: 'Content...',
                      border: InputBorder.none,
                      hintStyle: textSecondary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTitleNotes() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            color: colSecondary,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Notes Title",
                    style: GoogleFonts.mcLaren(fontSize: 17),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    controller: _tecJudul,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Title...',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _addNotes(),
      child: Icon(
        Icons.check,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Tambah Notes",
      ),
      elevation: 0,
    );
  }
}
