import 'dart:convert';

import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/utils/link.dart' as link;

class KategoriProvider {
  Future<List> getAllKategori(BuildContext context) async {
    final result =
        await http.post(link.Link.server + "getAllKategori.php", body: {});
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
