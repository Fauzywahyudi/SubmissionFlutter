import 'package:flutter/material.dart';

class TambahMahasiswa extends StatefulWidget {
  static String routeName = "/TambahMahasiswa";
  @override
  _TambahMahasiswaState createState() => _TambahMahasiswaState();
}

class _TambahMahasiswaState extends State<TambahMahasiswa> {
  var _tecNim = TextEditingController();
  var _tecNama = TextEditingController();
  var _tecTmpLahir = TextEditingController();
  var _tecTglLahir = TextEditingController();
  var _tecalamat = TextEditingController();

  List _jurusan = [
    "Teknik Informatika",
    "Sistem Komputer",
    "Sistem Informasi",
  ];
  List _jenisKelamin = [
    "Laki-laki",
    "Perempuan",
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItemsJurusan;
  List<DropdownMenuItem<String>> _dropDownMenuItemsJk;
  String _currentJurusan;
  String _currentJk;

  @override
  void initState() {
    _dropDownMenuItemsJurusan = getDropDownMenuItemsJurusan();
    _currentJurusan = _dropDownMenuItemsJurusan[0].value;
    _dropDownMenuItemsJk = getDropDownMenuItemsJk();
    _currentJk = _dropDownMenuItemsJk[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsJurusan() {
    List<DropdownMenuItem<String>> items = new List();
    for (String jurusan in _jurusan) {
      items.add(new DropdownMenuItem(value: jurusan, child: new Text(jurusan)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsJk() {
    List<DropdownMenuItem<String>> items = new List();
    for (String jk in _jenisKelamin) {
      items.add(new DropdownMenuItem(value: jk, child: new Text(jk)));
    }
    return items;
  }

  void changedDropDownItemJurusan(String selectedJurusan) {
    setState(() {
      _currentJurusan = selectedJurusan;
    });
  }

  void changedDropDownItemJk(String selectedJk) {
    setState(() {
      _currentJk = selectedJk;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Mahasiswa"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _tecNim,
                decoration: _inputDecor("Nim", Icons.person),
              ),
              TextField(
                controller: _tecNama,
                decoration: _inputDecor("Nama", Icons.person),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.wc, color: Colors.black54),
                      SizedBox(width: 10),
                      Text("Jenis Kelamin"),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _currentJk,
                      items: _dropDownMenuItemsJk,
                      onChanged: changedDropDownItemJk,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.school, color: Colors.black54),
                      SizedBox(width: 10),
                      Text("Jurusan"),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _currentJurusan,
                      items: _dropDownMenuItemsJurusan,
                      onChanged: changedDropDownItemJurusan,
                    ),
                  )
                ],
              ),
              TextField(
                controller: _tecTmpLahir,
                decoration: _inputDecor("Tempat Lahir", Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
    );
  }
}
