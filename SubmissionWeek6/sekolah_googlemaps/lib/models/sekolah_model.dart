import 'package:firebase_database/firebase_database.dart';

class SekolahModel {
  String key;
  String namaSekolah;
  String deskripsi;
  String long;
  String lat;
  bool completed;
  SekolahModel(
    this.namaSekolah,
    this.deskripsi,
    this.long,
    this.lat,
    this.completed,
  );
  SekolahModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        namaSekolah = snapshot.value['namaSekolah'],
        deskripsi = snapshot.value['deskripsi'],
        long = snapshot.value['long'],
        lat = snapshot.value['lat'],
        completed = snapshot.value['completed'];
  toJson() {
    return {
      "namaSekolah": namaSekolah,
      "deskripsi": deskripsi,
      "long": long,
      "lat": lat,
      "completed": completed
    };
  }
}
