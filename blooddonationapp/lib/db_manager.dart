import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'donnor_model.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  // static final table = 'category';
  static const tableDoner = 'donnerTable';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAddress = 'address';
  static const columnMobile = 'mobile';
  static const columnCategory = 'cat';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database?> get database1 async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    // await db.execute('''
    //       CREATE TABLE $table (
    //         $columnId INTEGER PRIMARY KEY,
    //         $columnName TEXT NOT NULL
    //       )
    //       ''');
    await db.execute('''
          CREATE TABLE $tableDoner (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL, 
            $columnAddress TEXT NOT NULL, 
            $columnMobile TEXT NOT NULL, 
            $columnCategory TEXT NOT NULL 
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  // Future<int> insert(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   return await db.insert(table, row);
  // }

  Future<int> insertDonner(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(tableDoner, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  // Future<List<Map<String, dynamic>>> queryAllRows() async {
  //   Database db = await instance.database;
  //   return await db.query(table);
  // }

  Future<List<Map<String, dynamic>>> queryAllRowsofDonner() async {
    Database db = await instance.database;
    return await db.query(tableDoner);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount() async {
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(
  //       await db.rawQuery('SELECT COUNT(*) FROM $table')) ??
  //       0;
  // }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnId];
  //   return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  // }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  // Future<int> delete(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  // }

  Future<int> deleteDonner(int id) async {
    Database db = await instance.database;
    return await db.delete(tableDoner, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map>> getDonner(int id) async {
    Database db = await instance.database;
    List<Map> result = await db.rawQuery("""SELECT * FROM $tableDoner WHERE $columnId = '$id'""");
    return result;
  }

  Future<int> updateDonner({required Map<String, dynamic> row,required int id}) async {
    Database? db = await instance.database;
    return await db.update(tableDoner, row,where: "${columnId} =?" ,whereArgs: [id]);
  }
}
