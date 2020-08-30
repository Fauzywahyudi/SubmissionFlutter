class User {
  int _idUser;
  String _username;
  String _nama;
  String _jk;
  String _tglDaftar;

  User(
    this._idUser,
    this._username,
    this._nama,
    this._jk,
    this._tglDaftar,
  );

  int getId() => this._idUser;
  String getUsername() => this._username;
  String getNama() => this._nama;
  String getJk() => this._jk;
  String getTglDaftar() => this._tglDaftar;

  void setId(int value) => this._idUser = value;
  void setUsername(String value) => this._username = value;
  void setNama(String value) => this._nama = value;
  void setJk(String value) => this._jk = value;
  void setTglDaftar(String value) => this._tglDaftar = value;
}
