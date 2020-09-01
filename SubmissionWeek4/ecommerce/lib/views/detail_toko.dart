import 'package:ecommerce/models/toko.dart';
import 'package:ecommerce/providers/toko_provider.dart';
import 'package:ecommerce/utils/assets/color.dart';
import 'package:flutter/material.dart';

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
        body: _isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                color: colPrimary,
                child: Center(
                  child: Text(_dataToko.getNamaToko()),
                ),
              ),
      ),
    );
  }
}
