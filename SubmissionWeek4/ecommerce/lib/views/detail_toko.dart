import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/models/toko.dart';
import 'package:ecommerce/providers/toko_provider.dart';
import 'package:ecommerce/utils/assets/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailToko extends StatefulWidget {
  final idToko;

  const DetailToko({Key key, this.idToko}) : super(key: key);
  @override
  _DetailTokoState createState() => _DetailTokoState();
}

class _DetailTokoState extends State<DetailToko> {
  Toko _dataToko;
  TokoProvider _tokoProvider = TokoProvider();
  bool _isLoading = true;

  void _getDataToko(int id) async {
    final result = await _tokoProvider.getTokoById(context, id);
    setState(() {
      _dataToko = result;
      _isLoading = false;
    });
  }

  // String get _namaToko => _dataToko.getNamaToko() ?? "";

  @override
  void initState() {
    _getDataToko(int.parse(widget.idToko));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.idToko,
      child: Scaffold(
        backgroundColor: colPrimary,
        body: _isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                color: colPrimary,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _dataToko.getNamaToko(),
                        style: GoogleFonts.mcLaren(
                          color: colSecondary,
                          fontSize: 25,
                        ),
                      ),
                      AutoSizeText(
                        _dataToko.getAlamatToko(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: GoogleFonts.mcLaren(
                          color: colSecondary,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
