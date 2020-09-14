import 'package:crud_sqflite/utils/assets.dart';
import 'package:crud_sqflite/views/edit_mahasiswa.dart';
import 'package:flutter/material.dart';

class DetailMahasiswa extends StatefulWidget {
  final data;

  const DetailMahasiswa({Key key, this.data}) : super(key: key);
  @override
  _DetailMahasiswaState createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pushPage(
              context,
              EditMahasiswa(
                data: widget.data,
              ));
          popPage(context);
        },
        tooltip: "Edit",
        child: Icon(Icons.edit),
      ),
      appBar: AppBar(title: Text(widget.data['nama'])),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person_pin),
                title: Text(widget.data['nim']),
                subtitle: Text("NIM Mahasiswa"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(widget.data['nama']),
                subtitle: Text("Nama Lengkap"),
              ),
              ListTile(
                leading: Icon(Icons.wc),
                title: Text(widget.data['jk']),
                subtitle: Text("Jenis Kelamin"),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text(widget.data['jurusan']),
                subtitle: Text("Jurusan"),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text(widget.data['tmpLahir']),
                subtitle: Text("Tempat Lahir"),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(widget.data['tglLahir']),
                subtitle: Text("Tanggal Lahir"),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(widget.data['alamat']),
                subtitle: Text("Alamat"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
