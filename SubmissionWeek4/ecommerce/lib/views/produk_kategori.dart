import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/providers/produk_provider.dart';
import 'package:ecommerce/views/detail_produk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/utils/link.dart' as link;
import 'package:intl/intl.dart';

class ProdukKategori extends StatefulWidget {
  final data;

  const ProdukKategori({Key key, this.data}) : super(key: key);
  @override
  _ProdukKategoriState createState() => _ProdukKategoriState();
}

class _ProdukKategoriState extends State<ProdukKategori> {
  final formatter = new NumberFormat.simpleCurrency(
    locale: "IDR",
    decimalDigits: 0,
  );

  ProdukProvider _produkProvider = ProdukProvider();

  Future<List> _getProdukByKategori() async {
    final result = await _produkProvider.getProdukByKategori(
        context, int.parse(widget.data['id_kategori']));
    return result;
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_kategori']),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List>(
          future: _getProdukByKategori(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? RefreshIndicator(
                    onRefresh: handleRefresh,
                    child: GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return _buildItemGrid(snapshot.data[index]);
                        }),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildItemGrid(var data) {
    return InkWell(
      onTap: () async {
        pushPage(context, DetailProduk(data: data));
      },
      child: Card(
        child: Container(
          width: 150,
          child: Column(
            children: [
              Container(
                height: 150,
                width: 140,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    // color: colPrimary,
                    ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    link.Link.imageProduk + data['thumbnail'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AutoSizeText(
                data['nama_produk'],
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 15),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              AutoSizeText(
                formatter.format(int.parse(data['harga'])),
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 17, color: colPrimary),
                maxLines: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
