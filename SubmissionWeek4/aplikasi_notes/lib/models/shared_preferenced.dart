import 'package:aplikasi_notes/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataShared {
  Future<int> getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int idUser = sharedPreferences.getInt("id");
    return idUser;
  }

  Future<int> getValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int value = sharedPreferences.getInt("value");
    return value;
  }

  Future<User> getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User user;
    int id = sharedPreferences.getInt("id");
    String username = sharedPreferences.getString("username");
    String nama = sharedPreferences.getString("nama");
    String jk = sharedPreferences.getString("jk");
    String tglDaftar = sharedPreferences.getString("tgl_daftar");
    user = User(id, username, nama, jk, tglDaftar);

    return user;
  }

  Future saveDataPref(int value, User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", value);
    sharedPreferences.setInt("id", user.getId());
    sharedPreferences.setString("username", user.getUsername());
    sharedPreferences.setString("nama", user.getNama());
    sharedPreferences.setString("jk", user.getJk());
    sharedPreferences.setString("tgl_daftar", user.getTglDaftar());
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", null);
  }
}
