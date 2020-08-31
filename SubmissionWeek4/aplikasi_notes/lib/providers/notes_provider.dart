import 'dart:convert';

import 'package:aplikasi_notes/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_notes/utils/link.dart' as link;

class NotesProvider {
  Future<int> addNotes(
      BuildContext context, int id, String judul, String isi) async {
    final result = await http.post(link.Link.server + "addNotes.php", body: {
      "id": id.toString(),
      "judul": judul,
      "isi": isi,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      messageSuccess(context, pesan);
    } else {
      messageDanger(context, pesan);
    }
    return value;
  }
}
