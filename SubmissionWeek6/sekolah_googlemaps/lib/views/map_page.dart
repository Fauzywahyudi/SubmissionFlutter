import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sekolah_googlemaps/models/sekolah_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final SekolahModel sekolah;

  const MapPage({Key key, this.sekolah}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _latLong;

  @override
  void initState() {
    _latLong = LatLng(
        double.parse(widget.sekolah.lat), double.parse(widget.sekolah.long));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sekolah.namaSekolah)),
      body: Container(
        child: ListView(
          children: [
            Card(
              child: Container(
                height: 300,
                width: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _latLong,
                    zoom: 15,
                  ),
                  markers: <Marker>[
                    Marker(
                        markerId: MarkerId(widget.sekolah.namaSekolah),
                        position: _latLong,
                        infoWindow: InfoWindow(
                          title: widget.sekolah.namaSekolah,
                        ))
                  ].toSet(),
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.sekolah.namaSekolah,
                      style: GoogleFonts.mcLaren(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Lat:${widget.sekolah.lat} Long:${widget.sekolah.long} "),
                  ),
                  ListTile(
                    subtitle: Text(
                      widget.sekolah.deskripsi,
                      style: GoogleFonts.mcLaren(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
