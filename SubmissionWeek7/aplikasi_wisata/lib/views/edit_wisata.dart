import 'dart:async';
import 'dart:io';

import 'package:aplikasi_wisata/models/wisata.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWisata extends StatefulWidget {
  static const routeName = '/EditWisata';
  final Wisata dataWisata;

  const AddWisata({Key key, this.dataWisata}) : super(key: key);
  @override
  _AddWisataState createState() => _AddWisataState();
}

class _AddWisataState extends State<AddWisata> {
  var _tecNama;
  var _tecLokasi;
  var _tecDeskripsi;
  var _tecLat;
  var _tecLong;

  String _errNama;
  String _errLokasi;
  String _errDeskripsi;
  String _errLat;
  String _errLong;
  TypeOperation typeOperation = TypeOperation.download;
  bool isLoading = true;
  bool isSuccess = true;
  bool isGridView = true;

  File _image;
  String filename;
  SharedPreferences sharedPreferences;
  DatabaseReference _wisataRef;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
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
    _wisataRef = _database.reference().child("wisata");
    _tecNama = TextEditingController(text: widget.dataWisata.nama);
    _tecLokasi = TextEditingController(text: widget.dataWisata.lokasi);
    _tecDeskripsi = TextEditingController(text: widget.dataWisata.deskripsi);
    _tecLat = TextEditingController(text: widget.dataWisata.lat.toString());
    _tecLong = TextEditingController(text: widget.dataWisata.long.toString());
    _errNama = null;
    _errLokasi = null;
    _errDeskripsi = null;
    _errLat = null;
    _errLong = null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      key: scaffoldState,
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(),
      body: Stack(
        children: [
          _buildBody(),
          _buildWidgetLoading(),
        ],
      ),
    );
  }

  Widget _buildWidgetLoading() {
    if (isLoading && typeOperation == TypeOperation.upload ||
        typeOperation == TypeOperation.delete) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[900].withOpacity(0.8),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container();
    }
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
    if (_image == null) {
      Fluttertoast.showToast(
          msg: 'Silahkan pilih foto objek wisata',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (_errNama != null ||
        _errLokasi != null ||
        _errLat != null ||
        _errLong != null ||
        _errDeskripsi != null) {
      Fluttertoast.showToast(
          msg: 'Semua input belum valid',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      uploadImage();
    }
  }

  Future onSaveDatabase(String urlImage) async {
    Wisata wisata = Wisata(
        null,
        _tecNama.text,
        _tecLokasi.text,
        _tecDeskripsi.text,
        double.parse(_tecLat.text),
        double.parse(_tecLong.text),
        urlImage);
    await _wisataRef.push().set(wisata.toJson());
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text('Add data successfully'),
    ));
    Navigator.pop(context);
  }

  Future<void> uploadImage() async {
    List<String> splitPath = _image.path.split('/');
    String filename = splitPath[splitPath.length - 1];
    StorageReference ref =
        firebaseStorage.ref().child('images').child(filename);
    StorageUploadTask uploadTask = ref.putFile(_image);
    StreamSubscription streamSubscription =
        uploadTask.events.listen((event) async {
      var eventType = event.type;
      if (eventType == StorageTaskEventType.progress) {
        setState(() {
          typeOperation = TypeOperation.upload;
          isLoading = true;
        });
      } else if (eventType == StorageTaskEventType.failure) {
        scaffoldState.currentState.showSnackBar(SnackBar(
          content: Text('Photo failed to upload'),
        ));
        setState(() {
          isLoading = false;
          isSuccess = false;
          typeOperation = null;
        });
      } else if (eventType == StorageTaskEventType.success) {
        var downloadUrl = await event.snapshot.ref.getDownloadURL();

        onSaveDatabase(downloadUrl.toString());
        setState(() {
          isLoading = false;
          isSuccess = true;
          typeOperation = null;
        });
      }
    });
    await uploadTask.onComplete;
    streamSubscription.cancel();
  }
}

enum TypeOperation {
  upload,
  download,
  delete,
}
