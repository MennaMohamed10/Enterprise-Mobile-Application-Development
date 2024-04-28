import 'package:path_provider/path_provider.dart';
import 'package:signupscreen/UserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static  Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_Name = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';
  static const String C_gender = 'gender';
  static const String C_level= 'level';


  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_Name TEXT, "
        " $C_Email TEXT,"
        " $C_UserID TEXT, "
        " $C_level TEXT, "
        " $C_Password TEXT, "
        " $C_gender TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }


  Future<bool> checkUserExists(String username, String password) async {
    var dbClient = await db;
    var result = await dbClient.query(
      Table_User,
      where: "$C_Name = ? AND $C_Password = ?",
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
    }


  Future<void> updateUserData(String userId, String newName, String newPassword) async {
    var dbClient = await db;
    await dbClient.update(
      Table_User,
      {
        C_Name: newName,
        C_Password: newPassword,
      },
      where: "$C_UserID = ?",
      whereArgs: [userId],
    );
  }


}