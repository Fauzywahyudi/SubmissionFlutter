import 'package:crud_sqflite/models/model_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crud_sqflite/models/model_mahasiswa.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  final String tableMahasiswa = 'mahasiswa';
  final String tableUser = 'user';

  // mahasiswa
  final String columId = 'id';
  final String columnNim = 'nim';
  final String columnNama = 'nama';
  final String columnJk = 'jk';
  final String columnJurusan = 'jurusan';
  final String columnTmpLahir = 'tmpLahir';
  final String columnTglLahir = 'tglLahir';
  final String columnAlamat = 'alamat';

  // user
  final String columnUsername = 'username';
  final String columnPassword = 'password';
  final String columnStatus = 'status';

  static Database _db;

  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mahasiswa.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newViersion) async {
    await db
        .execute("CREATE TABLE $tableMahasiswa($columId INTEGER PRIMARY KEY, "
            "$columnNim TEXT, "
            "$columnNama TEXT, "
            "$columnJk TEXT, "
            "$columnJurusan TEXT, "
            "$columnTmpLahir TEXT, "
            "$columnTglLahir TEXT, "
            "$columnAlamat TEXT)");
    await db.execute("CREATE TABLE $tableUser($columId INTEGER PRIMARY KEY, "
        "$columnUsername TEXT, "
        "$columnNama TEXT, "
        "$columnPassword TEXT, "
        "$columnStatus TEXT)");
  }

  Future<int> saveMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableMahasiswa, mahasiswa.toMap());
    return result;
  }

  Future<int> saveUser(ModelUser user) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableUser, user.toMap());
    return result;
  }

  Future<ModelUser> getLogin(String user, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM $tableUser WHERE $columnUsername = '$user' and $columnPassword = '$password'");

    if (res.length > 0) {
      ModelUser data = ModelUser.fromMap(res.first);
      await dbClient.rawQuery(
          "UPDATE $tableUser SET $columnStatus = 'online' WHERE $columId='${data.id}'");
      return ModelUser.fromMap(res.first);
    }
    return null;
  }

  Future<ModelUser> getOnline() async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery("SELECT * FROM $tableUser WHERE $columnStatus = 'online'");

    if (res.length > 0) {
      return ModelUser.fromMap(res.first);
    }
    return null;
  }

  Future getLogout(ModelUser user) async {
    var dbClient = await db;
    await dbClient.rawQuery(
        "UPDATE $tableUser SET $columnStatus = 'offline' WHERE $columId='${user.id}'");
  }

  Future<List> getAllUser() async {
    var dbClient = await db;
    var result = await dbClient.query(tableUser, columns: [
      columId,
      columnUsername,
      columnNama,
      columnPassword,
      columnStatus,
    ]);
    return result.toList();
  }

  Future<List> getAllMahasiswa() async {
    var dbClient = await db;
    var result = await dbClient.query(tableMahasiswa, columns: [
      columId,
      columnNim,
      columnNama,
      columnJk,
      columnJurusan,
      columnTmpLahir,
      columnTglLahir,
      columnAlamat,
    ]);
    return result.toList();
  }

  Future<int> updateMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await db;
    return await dbClient.update(tableMahasiswa, mahasiswa.toMap(),
        where: "$columId = ?", whereArgs: [mahasiswa.id]);
  }

  Future<int> deleteMahasiswa(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableMahasiswa, where: "$columId = ?", whereArgs: [id]);
  }
}
