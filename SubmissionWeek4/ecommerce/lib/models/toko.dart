class Toko {
  int _idToko;
  String _namaToko;
  String _alamatToko;

  Toko(this._idToko, this._namaToko, this._alamatToko);

  int getIdToko() => this._idToko;
  String getNamaToko() => this._namaToko;
  String getAlamatToko() => this._alamatToko;

  void setIdToko(int value) => this._idToko = value;
  void setNamaToko(String value) => this._namaToko = value;
  void setAlamatToko(String value) => this._alamatToko = value;
}
