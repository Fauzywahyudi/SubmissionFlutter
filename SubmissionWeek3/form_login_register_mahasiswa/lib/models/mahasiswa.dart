class Mahasiswa {
  int _id;
  String _nim;
  String _pass;
  String _nama;
  String _jk;
  String _jurusan;
  String _alamat;
  String _tglDaftar;

  Mahasiswa(this._id, this._nim, this._pass, this._nama, this._jk,
      this._jurusan, this._alamat, this._tglDaftar);

  int getId() => this._id;
  String getNim() => this._nim;
  String getPass() => this._pass;
  String getNama() => this._nama;
  String getJK() => this._jk;
  String getJurusan() => this._jurusan;
  String getAlamat() => this._alamat;
  String getTglDaftar() => this._tglDaftar;

  void setId(int id) => this._id = id;
  void setNim(String value) => this._nim = value;
  void setPass(String value) => this._pass = value;
  void setNama(String value) => this._nama = value;
  void setJK(String value) => this._jk = value;
  void setJurusan(String value) => this._jurusan = value;
  void setAlamat(String value) => this._alamat = value;
  void setTglDaftar(String value) => this._tglDaftar = value;
}
