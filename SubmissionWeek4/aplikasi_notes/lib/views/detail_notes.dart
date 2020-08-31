import 'package:flutter/material.dart';

class DetailNotes extends StatefulWidget {
  final data;

  const DetailNotes({Key key, this.data}) : super(key: key);
  @override
  _DetailNotesState createState() => _DetailNotesState();
}

class _DetailNotesState extends State<DetailNotes> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.data['id_notes'],
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text(widget.data['judul_notes']),
          ),
        ),
      ),
    );
  }
}
