class ModelMahasiswa {
  int _id;
  String _nim;
  String _nama;
  String _jk;
  String _jurusan;
  String _tmpLahir;
  String _tglLahir;
  String _alamat;

  ModelMahasiswa(this._nim, this._nama, this._jk, this._jurusan, this._tmpLahir,
      this._tglLahir, this._alamat);

  ModelMahasiswa.map(dynamic obj) {
    this._id = obj['id'];
    this._nim = obj['nim'];
    this._nama = obj['nama'];
    this._jk = obj['jk'];
    this._jurusan = obj['jurusan'];
    this._tmpLahir = obj['tmpLahir'];
    this._tglLahir = obj['tglLahir'];
    this._alamat = obj['alamat'];
  }

  void setId(int value) => this._id = value;

  int get id => _id;
  String get nim => _nim;
  String get nama => _nama;
  String get jk => _jk;
  String get jurusan => _jurusan;
  String get tmpLahir => _tmpLahir;
  String get tglLahir => _tglLahir;
  String get alamat => _alamat;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nim'] = _nim;
    map['nama'] = _nama;
    map['jk'] = _jk;
    map['jurusan'] = _jurusan;
    map['tmpLahir'] = _tmpLahir;
    map['tglLahir'] = _tglLahir;
    map['alamat'] = _alamat;
    return map;
  }

  ModelMahasiswa.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nim = map['nim'];
    this._nama = map['nama'];
    this._jk = map['jk'];
    this._jurusan = map['jurusan'];
    this._tmpLahir = map['tmpLahir'];
    this._tglLahir = map['tglLahir'];
    this._alamat = map['alamat'];
  }
}
