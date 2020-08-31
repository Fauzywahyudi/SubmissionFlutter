class User {
  int _idUser;
  String _email;
  String _nama;
  String _nohp;
  String _alamat;
  String _tglDaftar;

  User(
    this._idUser,
    this._email,
    this._nama,
    this._nohp,
    this._alamat,
    this._tglDaftar,
  );

  int getId() => this._idUser;
  String getEmail() => this._email;
  String getNama() => this._nama;
  String getNohp() => this._nohp;
  String getAlamat() => this._alamat;
  String getTglDaftar() => this._tglDaftar;

  void setId(int value) => this._idUser = value;
  void setEmail(String value) => this._email = value;
  void setNama(String value) => this._nama = value;
  void setNohp(String value) => this._nohp = value;
  void setAlamat(String value) => this._alamat = value;
  void setTglDaftar(String value) => this._tglDaftar = value;
}
