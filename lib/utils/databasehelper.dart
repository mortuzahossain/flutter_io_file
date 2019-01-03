import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

// Skeleton Style
class DatabaseHelper{

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnUser = "username";
  final String columnPassword = "password";

  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;
  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"maindb.db");
    var Db = await openDatabase(path,version: 1,onCreate: _oncreate);


  }

  // Create Database
  void _oncreate(Database db, int version) async {
    String sql = "CREATE TABLE $tableUser ($columnId INTEGER PRIMARY KEY, $columnUser TEXT,$columnPassword TEXT)";
    await db.execute(sql);
  }

  // Insert Data Into Database
  Future<int> saveUser (User user) async{
    var dbClient = await db;
    int res = await dbClient.insert(tableUser, user.toMap());
    return res;
  }

  // Read Data -> Get User
  Future<List> getAllusers() async{
    var dbClient = await db;
    String sql = "SELECT * FROM $tableUser";
    var result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  // Read Data Only One User
  Future<User> getUser(int id) async{
    var dbClient = await db;
    String sql = "SELECT * FROM $tableUser WHERE $columnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0){
      return null;
    }
    return new User.fromMap(result.first);
  }

  // Counting All The User
  Future<int> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  // Update Data
  Future<int> updateUser(User user) async{
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),where: "$columnId = ?",whereArgs: [user.id]);
  }

  // Delete Data
  Future<int> deleteuser(int id) async{
    var dbClient = await db;
    return await dbClient.delete(tableUser,where: "$columnId = ?",whereArgs: [id]);
  }

  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }

}