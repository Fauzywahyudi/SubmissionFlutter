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
      backgroundColor: colPrimary,
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [_buildJudul(), _buildContent(context)],
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
        "Edit Notes",
      ),
      elevation: 0,
    );
  }

  Container _buildContent(BuildContext context) {
    var media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      height: media.size.height,
      margin: EdgeInsets.only(top: 170, left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: colSecondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Isi Notes",
                    style: GoogleFonts.mcLaren(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: _tecIsi,
                style: GoogleFonts.mcLaren(color: colDark),
                minLines: 8,
                maxLines: 16,
                decoration: InputDecoration(
                  hintText: 'Content...',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.mcLaren(color: colLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildJudul() {
    return Container(
        height: 150,
        color: colPrimary,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: _tecJudul,
                textCapitalization: TextCapitalization.words,
                minLines: 1,
                maxLines: 2,
                style: GoogleFonts.mcLaren(
                  fontSize: 25,
                  color: colSecondary,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Title...',
                  hintStyle: GoogleFonts.mcLaren(
                    fontSize: 25,
                    color: colSecondary.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ));
  }
}
