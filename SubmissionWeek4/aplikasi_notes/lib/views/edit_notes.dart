import 'package:aplikasi_notes/providers/notes_provider.dart';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNotes extends StatefulWidget {
  final data;

  const EditNotes({Key key, this.data}) : super(key: key);
  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  NotesProvider _notesProvider = NotesProvider();
  var _tecJudul = TextEditingController();
  var _tecIsi = TextEditingController();

  void _editNotes() async {
    if (_tecJudul.text.isNotEmpty && _tecIsi.text.isNotEmpty) {
      int value = await _notesProvider.editNotes(context,
          int.parse(widget.data['id_notes']), _tecJudul.text, _tecIsi.text);
      if (value == 1) Navigator.pop(context);
    } else {
      messageInfo(context, "Harap isi semua data!");
    }
  }

  @override
  void initState() {
    setState(() {
      _tecJudul.text = widget.data['judul_notes'];
      _tecIsi.text = widget.data['isi_notes'];
    });
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
      onPressed: () => _editNotes(),
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
