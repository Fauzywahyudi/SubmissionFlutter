import 'package:crud_sqflite/models/model_mahasiswa.dart';
import 'package:crud_sqflite/sqflite/db_helper.dart';
import 'package:crud_sqflite/utils/assets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditMahasiswa extends StatefulWidget {
  static String routeName = "/EditMahasiswa";
  final data;

  const EditMahasiswa({Key key, this.data}) : super(key: key);
  @override
  _EditMahasiswaState createState() => _EditMahasiswaState();
}

class _EditMahasiswaState extends State<EditMahasiswa> {
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController _tecNim;
  TextEditingController _tecNama;
  TextEditingController _tecTmpLahir;
  TextEditingController _tecTglLahir;
  TextEditingController _tecAlamat;

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
    _tecNim = TextEditingController(text: widget.data['nim']);
    _tecNama = TextEditingController(text: widget.data['nama']);
    _tecTmpLahir = TextEditingController(text: widget.data['tmpLahir']);
    _tecTglLahir = TextEditingController(text: widget.data['tglLahir']);
    _tecAlamat = TextEditingController(text: widget.data['alamat']);

    _dropDownMenuItemsJurusan = getDropDownMenuItemsJurusan();
    _currentJurusan = widget.data['jurusan'];
    _dropDownMenuItemsJk = getDropDownMenuItemsJk();
    _currentJk = widget.data['jk'];
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

  bool _validasi() {
    if (_tecNim.text.isEmpty) return false;
    if (_tecNama.text.isEmpty) return false;
    if (_tecTmpLahir.text.isEmpty) return false;
    if (_tecTglLahir.text.isEmpty) return false;
    if (_tecAlamat.text.isEmpty) return false;
    if (_currentJk.isEmpty) return false;
    if (_currentJurusan.isEmpty) return false;
    return true;
  }

  Future _edit(int id) async {
    DatabaseHelper db = DatabaseHelper();
    if (_validasi()) {
      ModelMahasiswa mahasiswa = ModelMahasiswa(
          _tecNim.text,
          _tecNama.text,
          _currentJk,
          _currentJurusan,
          _tecTmpLahir.text,
          _tecTglLahir.text,
          _tecAlamat.text);
      mahasiswa.setId(id);
      await db.updateMahasiswa(mahasiswa).then((_) => Navigator.pop(context));
      messageSuccess("Berhasil diedit");
    } else {
      messageInfo("Harap isi semua data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Mahasiswa")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _edit(widget.data['id']),
        child: Icon(Icons.check),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _tecNim,
                keyboardType: TextInputType.number,
                decoration: _inputDecor("NIM", Icons.person),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _tecNama,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecor("Nama Lengkao", Icons.person),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              TextField(
                controller: _tecTmpLahir,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecor("Tempat Lahir", Icons.location_on),
              ),
              SizedBox(height: 15),
              DateTimeField(
                format: format,
                controller: _tecTglLahir,
                decoration: InputDecoration(
                    labelText: "Tanggal Lahir",
                    prefixIcon: Icon(Icons.calendar_today)),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              SizedBox(height: 15),
              TextField(
                controller: _tecAlamat,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecor("Alamat", Icons.home),
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
