import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddWisata extends StatefulWidget {
  static const routeName = '/AddWisata';
  @override
  _AddWisataState createState() => _AddWisataState();
}

class _AddWisataState extends State<AddWisata> {
  var _tecNama = TextEditingController();
  var _tecLokasi = TextEditingController();
  var _tecDeskripsi = TextEditingController();
  var _tecLat = TextEditingController();
  var _tecLong = TextEditingController();

  String _errNama;
  String _errLokasi;
  String _errDeskripsi;
  String _errLat;
  String _errLong;

  File _image;
  String filename;
  final picker = ImagePicker();
  var _paddTextField = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  InputDecoration _inputDecor(String label, String error) {
    return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        enabledBorder: OutlineInputBorder(),
        errorText: error);
  }

  @override
  void initState() {
    super.initState();
    _errNama = null;
    _errLokasi = null;
    _errDeskripsi = null;
    _errLat = null;
    _errLong = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(),
      body: _buildBody(),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      onPressed: () => onClickSave(),
      child: Icon(Icons.check),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Tambah Tempat Wisata'),
    );
  }

  Container _buildBody() {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue[200],
              child: Stack(
                children: [
                  Container(
                    child: _image == null
                        ? Center(child: Text('No image selected.'))
                        : Center(child: Image.file(_image)),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.image,
                          color: Colors.blue,
                        ),
                        onPressed: () => getImage(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: _paddTextField,
              child: TextField(
                controller: _tecNama,
                onChanged: (v) {
                  setState(() {
                    if (v.isEmpty)
                      _errNama = 'Tidak boleh kosong';
                    else
                      _errNama = null;
                  });
                },
                decoration: _inputDecor('Nama Wisata', _errNama),
              ),
            ),
            Padding(
              padding: _paddTextField,
              child: TextField(
                controller: _tecLokasi,
                onChanged: (v) {
                  setState(() {
                    if (v.isEmpty)
                      _errLokasi = 'Tidak boleh kosong';
                    else
                      _errLokasi = null;
                  });
                },
                decoration: _inputDecor('Lokasi Wisata', _errLokasi),
              ),
            ),
            Padding(
              padding: _paddTextField,
              child: TextField(
                controller: _tecLat,
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  setState(() {
                    try {
                      if (v.isEmpty) {
                        _errLat = 'Tidak boleh kosong';
                      } else {
                        double value = double.parse(v);
                        print(value);
                        _errLat = null;
                      }
                    } catch (e) {
                      _errLat = 'Format tidak sesuai';
                    }
                  });
                },
                decoration: _inputDecor('Latitude', _errLat),
              ),
            ),
            Padding(
              padding: _paddTextField,
              child: TextField(
                controller: _tecLong,
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  setState(() {
                    try {
                      if (v.isEmpty) {
                        _errLong = 'Tidak boleh kosong';
                      } else {
                        double value = double.parse(v);
                        print(value);
                        _errLong = null;
                      }
                    } catch (e) {
                      _errLong = 'Format tidak sesuai';
                    }
                  });
                },
                decoration: _inputDecor('Longitude', _errLong),
              ),
            ),
            Padding(
              padding: _paddTextField,
              child: TextField(
                controller: _tecDeskripsi,
                minLines: 2,
                maxLines: 4,
                onChanged: (v) {
                  setState(() {
                    if (v.isEmpty)
                      _errDeskripsi = 'Tidak boleh kosong';
                    else
                      _errDeskripsi = null;
                  });
                },
                decoration: _inputDecor('Deskripsi', _errDeskripsi),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        filename = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  void validasiNama(String value) {
    if (value.isEmpty) {
      setState(() {
        _errNama = 'Tidak boleh kosong';
      });
    }
  }

  void onClickSave() {
    // if (_image == null) {
    //   Fluttertoast.showToast(
    //       msg: 'Silahkan pilih foto objek wisata',
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // } else if (_errNama.isNotEmpty ||
    //     _errLokasi.isNotEmpty ||
    //     _errLat.isNotEmpty ||
    //     _errLong.isNotEmpty ||
    //     _errDeskripsi.isNotEmpty) {
    //   Fluttertoast.showToast(
    //       msg: 'Semua input belum valid',
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // } else {
    //   // onSave();
    //   // uploadImage();
    // }
    uploadImage();
  }

  Future onSave() async {}

  Future<String> uploadImage() async {
    StorageReference reference = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    print("Download Url : $url");
    return "";
  }
}
