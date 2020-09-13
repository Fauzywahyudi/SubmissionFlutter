class ModelUser {
  int _id;
  String _username;
  String _nama;
  String _password;
  String _status;

  ModelUser(this._username, this._nama, this._password, this._status);

  ModelUser.map(dynamic obj) {
    this._id = obj['id'];
    this._username = obj['username'];
    this._nama = obj['nama'];
    this._password = obj['password'];
    this._status = obj['status'];
  }
  int get id => _id;
  String get username => _username;
  String get nama => _nama;
  String get password => _password;
  String get status => _status;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['username'] = _username;
    map['nama'] = _nama;
    map['password'] = _password;
    map['status'] = _status;
    return map;
  }

  ModelUser.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._nama = map['nama'];
    this._password = map['password'];
    this._status = map['status'];
  }
}
