import 'dart:convert';

import 'package:ecommerce/models/toko.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/utils/link.dart' as link;

class TokoProvider {
  Future<Toko> getTokoById(BuildContext context, int idToko) async {
    final result = await http.post(link.Link.server + "getTokoById.php", body: {
      "id": idToko.toString(),
    });
    final response = await json.decode(result.body);
    List data;
    Toko dataToko;
    int value = response['value'];
    String pesan = response['message'];

    if (value == 1) {
      data = json.decode(response['data']);
      dataToko = Toko(int.parse(data[0]['id_toko']), data[0]['nama_toko'],
          data[0]['alamat']);
    } else {
      messageDanger(context, pesan);
    }
    return dataToko;
  }
}
