import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/models/AssetcodeLocalModel.dart';


class Databaseassetcode {

  static final _databaseName = "assetcode.db";
  static final _databaseVersion = 1;

  static final table = 'asset_code';

  static final table2 = 'asset_code_tbl';

  static final columnId = 'id';
  static final columnassetcode = 'Assetcode';






  // make this a singleton class
  Databaseassetcode._privateConstructor();
  static final Databaseassetcode instance = Databaseassetcode._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }



  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnassetcode TEXT NOT NULL,
          )
          ''');
  }



  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(LocalStassetcodeModel detailModel) async {
    Database? db = await instance.database;
    return await db!.insert(table, {'assetcode': detailModel.assetcode});
  }



  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // // Queries rows based on the argument received
  // Future<List<Map<String, dynamic>>> queryRows(SettingName) async {
  //   Database? db = await instance.database;
  //   return await db!.query(table, where: "$columnesettingName LIKE '%$SettingName%'");
  // }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }


  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  deleteAll() async {
    Database? db = await instance.database;
    return await db!.rawDelete("Delete from $table");
  }


  Future<bool> deleteDb() async {
    bool databaseDeleted = false;
    print("onError");
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        print("onError>>${onError}");
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }

    return databaseDeleted;
  }

  Future closeDb() async {
    var dbClient = await instance.database;
    dbClient!.close();
  }
}



