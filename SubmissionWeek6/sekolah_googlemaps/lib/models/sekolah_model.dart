import 'package:firebase_database/firebase_database.dart';

class SekolahModel {
  String key;
  String namaSekolah;
  String deskripsi;
  String long;
  String lat;
  SekolahModel(
    this.namaSekolah,
    this.deskripsi,
    this.long,
    this.lat,
  );
  SekolahModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        namaSekolah = snapshot.value['namaSekolah'],
        deskripsi = snapshot.value['deskripsi'],
        long = snapshot.value['long'],
        lat = snapshot.value['lat'];
  toJson() {
    return {
      "namaSekolah": namaSekolah,
      "deskripsi": deskripsi,
      "long": long,
      "lat": lat,
    };
  }
}
