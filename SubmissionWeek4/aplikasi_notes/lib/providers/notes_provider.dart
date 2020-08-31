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

  Future<List> getAllNotes(BuildContext context, int id) async {
    final result = await http.post(link.Link.server + "getAllNotes.php", body: {
      "id": id.toString(),
    });
    final response = await json.decode(result.body);
    List data;
    int value = response['value'];
    String pesan = response['message'];

    if (value == 1) {
      data = json.decode(response['data']);
    } else {
      messageDanger(context, pesan);
    }
    return data;
  }

  Future<int> deleteNotes(BuildContext context, int id) async {
    final result = await http.post(link.Link.server + "deleteNotes.php", body: {
      "id": id.toString(),
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

  Future<int> editNotes(
      BuildContext context, int id, String judul, String isi) async {
    final result = await http.post(link.Link.server + "editNotes.php", body: {
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

  Future<List> getById(BuildContext context, int id) async {
    final result =
        await http.post(link.Link.server + "getNotesById.php", body: {
      "id": id.toString(),
    });
    final response = await json.decode(result.body);
    List data;
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      data = json.decode(response['data']);
    } else {
      messageDanger(context, pesan);
    }
    return data;
  }
}
