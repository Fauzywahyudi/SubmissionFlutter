import 'dart:convert';

import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/utils/link.dart' as link;

class ProdukProvider {
  Future<List> getAllTerlaris(BuildContext context) async {
    final result =
        await http.post(link.Link.server + "getAllTerlaris.php", body: {});
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

  Future<List> getAllProduk(BuildContext context) async {
    final result =
        await http.post(link.Link.server + "getAllProduk.php", body: {});
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

  Future<List> getProdukByKategori(BuildContext context, int idKategori) async {
    final result =
        await http.post(link.Link.server + "getProdukByKategori.php", body: {
      "id_kategori": idKategori.toString(),
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

  Future<List> getProdukByToko(BuildContext context, int idToko) async {
    final result =
        await http.post(link.Link.server + "getProdukByKategori.php", body: {
      "id_toko": idToko.toString(),
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

  Future<List> getProdukSearch(BuildContext context, String search) async {
    final result =
        await http.post(link.Link.server + "getProdukSearch.php", body: {
      "search": search,
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
