import 'package:firebase_database/firebase_database.dart';

class Wisata {
  String key;
  String nama;
  String lokasi;
  String deskripsi;
  String urlImage;
  double lat;
  double long;

  Wisata(this.key, this.nama, this.lokasi, this.deskripsi, this.lat, this.long,
      this.urlImage);

  Wisata.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        nama = snapshot.value['nama'],
        lokasi = snapshot.value['lokasi'],
        deskripsi = snapshot.value['deskripsi'],
        long = double.parse(snapshot.value['long'].toString()),
        lat = double.parse(snapshot.value['lat'].toString()),
        urlImage = snapshot.value['urlImage'];

  toJson() {
    return {
      "nama": nama,
      "lokasi": lokasi,
      "deskripsi": deskripsi,
      "lat": lat,
      "long": long,
      "urlImage": urlImage,
    };
  }
}

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
