import 'package:movie_app/models/user.dart';
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

  Future<bool> getValueOnboarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool value = sharedPreferences.getBool("onboarding");
    return value;
  }

  Future setValueOnboarding(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("onboarding", value);
  }

  Future<User> getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User user;
    int id = sharedPreferences.getInt("id");
    String email = sharedPreferences.getString("email");
    String nama = sharedPreferences.getString("nama");
    String nohp = sharedPreferences.getString("nohp");
    String alamat = sharedPreferences.getString("alamat");
    String tglDaftar = sharedPreferences.getString("tgl_daftar");
    user = User(id, email, nama, nohp, alamat, tglDaftar);

    return user;
  }

  Future saveDataPref(int value, User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", value);
    sharedPreferences.setInt("id", user.getId());
    sharedPreferences.setString("email", user.getEmail());
    sharedPreferences.setString("nama", user.getNama());
    sharedPreferences.setString("nohp", user.getNohp());
    sharedPreferences.setString("alamat", user.getAlamat());
    sharedPreferences.setString("tgl_daftar", user.getTglDaftar());
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", null);
  }
}
