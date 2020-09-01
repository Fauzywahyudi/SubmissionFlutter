import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/views/detail_toko.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/utils/link.dart' as link;
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class DetailProduk extends StatefulWidget {
  final data;

  const DetailProduk({Key key, this.data}) : super(key: key);
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  ScrollController _scrollController = new ScrollController();
  bool _lastStatus = true;
  Color get _colIconAppBar => isShrink ? Colors.transparent : colPrimary;
  final formatter = new NumberFormat.simpleCurrency(
    locale: "IDR",
    decimalDigits: 0,
  );

  List get _splitAlamat => widget.data['alamat'].toString().split("-");
  String get _alamat => _splitAlamat[0];
  String get _namaProduk => widget.data['nama_produk'].toString().length > 30
      ? widget.data['nama_produk'].toString().substring(0, 30) + "..."
      : widget.data['nama_produk'];

  _scrollListener() {
    if (isShrink != _lastStatus) {
      setState(() {
        _lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (350 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    print(widget.data['id_toko']);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              leading: Container(
                decoration: BoxDecoration(
                    color: _colIconAppBar, shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => popPage(context),
                  focusColor: colDark.withOpacity(0.3),
                ),
              ),
              actions: [
                Container(
                  decoration:
                      BoxDecoration(color: colPrimary, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(LineIcons.cart_plus),
                    onPressed: () {},
                    focusColor: colDark.withOpacity(0.3),
                  ),
                ),
              ],
              expandedHeight: 350,
              flexibleSpace: _buildFlexibleSpaceBar(),
            ),
          ];
        },
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(
                      widget.data['nama_produk'],
                      style: GoogleFonts.mcLaren(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              AutoSizeText(
                                formatter
                                    .format(int.parse(widget.data['harga'])),
                                maxLines: 1,
                                style: GoogleFonts.mcLaren(
                                    fontSize: 30,
                                    color: colPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Harga")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              AutoSizeText(
                                widget.data['terjual'],
                                maxLines: 1,
                                style: GoogleFonts.mcLaren(
                                    fontSize: 30,
                                    color: colPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Terjual"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              AutoSizeText(
                                widget.data['ratting'],
                                maxLines: 1,
                                style: GoogleFonts.mcLaren(
                                    fontSize: 30,
                                    color: colPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Ratting"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () => pushPage(
                        context,
                        DetailToko(
                          idToko: widget.data['id_toko'],
                        )),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Hero(
                            tag: widget.data['id_toko'],
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: colPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.store,
                                color: colSecondary,
                                size: 40,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data['nama_toko'],
                                style: GoogleFonts.lato(
                                    fontSize: 25, color: colPrimary),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: colDanger,
                                  ),
                                  Text(_alamat),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Deskripsi Produk",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: colPrimary),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['deskripsi']),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlexibleSpaceBar _buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      title: Text(
        _namaProduk,
        maxLines: 1,
      ),
      background: SafeArea(
        child: Container(
            decoration: BoxDecoration(color: colPrimary),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    link.Link.imageProduk + widget.data['thumbnail'],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: colDark.withOpacity(0.2),
                ),
              ],
            )),
      ),
    );
  }
}
