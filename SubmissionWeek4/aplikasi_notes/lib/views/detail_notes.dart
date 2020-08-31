import 'dart:async';

import 'package:aplikasi_notes/providers/notes_provider.dart';
import 'package:aplikasi_notes/utils/assets.dart';
import 'package:aplikasi_notes/views/edit_notes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailNotes extends StatefulWidget {
  final data;

  const DetailNotes({Key key, this.data}) : super(key: key);
  @override
  _DetailNotesState createState() => _DetailNotesState();
}

class _DetailNotesState extends State<DetailNotes> {
  NotesProvider _notesProvider = NotesProvider();
  String _judul;
  String _isi;

  void _dialogHapus(int id) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Hapus',
      desc: 'Yakin untuk hapus notes?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _notesProvider.deleteNotes(context, id);
        Navigator.pop(context);
        handleRefresh();
      },
    )..show();
  }

  void _edit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotes(
          data: widget.data,
        ),
      ),
    );
    _refreshData();
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  void _refreshData() async {
    List data = await _notesProvider.getById(
        context, int.parse(widget.data['id_notes']));
    setState(() {
      _judul = data[0]['judul_notes'];
      _isi = data[0]['isi_notes'];
    });
  }

  @override
  void initState() {
    setState(() {
      _judul = widget.data['judul_notes'];
      _isi = widget.data['isi_notes'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.data['id_notes'],
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: colPrimary,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [_builJudul(), _buildContent(context)],
            ),
          ),
        ),
      ),
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _isi,
                style: GoogleFonts.mcLaren(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _builJudul() {
    return Container(
      height: 150,
      color: colPrimary,
      child: Center(
        child: AutoSizeText(
          _judul,
          style: GoogleFonts.mcLaren(fontSize: 25, color: colSecondary),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("Notes"),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Hapus',
          onPressed: () => _dialogHapus(int.parse(widget.data['id_notes'])),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () => _edit(),
        ),
      ],
    );
  }
}
