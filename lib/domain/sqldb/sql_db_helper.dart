import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tdd/domain/model/task_model.dart';

class SqlDBHelper {
  final String tableName = "TASK";
  SqlDBHelper._();

  static final SqlDBHelper _db = SqlDBHelper._();

  factory SqlDBHelper() => _db;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return openDatabase(join(appDocDir.path, "task_database.db"),
        version: 1,
        onCreate: (db, version) => _onCreate(db, version),
        onUpgrade: (db, oldVersion, newVersion) =>
            _onUpgrade(db, oldVersion, newVersion));
  }

  _onCreate(Database db, int newVersion) => db.execute('''
  CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,path TEXT,isFinish INTEGER)
''');

  _onUpgrade(Database db, oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $tableName");
    _onCreate(db, newVersion);
  }

  Future<List<TaskModel>> getAllData() async {
    var res = await ((await database)!.query(tableName));

    if (res.isNotEmpty) {
      var data = res
          .map((e) => TaskModel(
              id: int.parse(e['id'].toString()),
              title: e['title'].toString(),
              path: e['path'].toString(),
              isFinish: int.parse(e['isFinish'].toString())))
          .toList();
      return data;
    } else {
      return [];
    }
  }

  insertData(TaskModel task) async =>
      await ((await database)!.insert(tableName, task.toMap()));

  updateData(TaskModel task) async => await ((await database)!
      .update(tableName, task.toMap(), where: "id = ?", whereArgs: [task.id]));

  deleteData(int id) async => await ((await database)!
      .delete(tableName, where: "id =?", whereArgs: [id]));
  deleteTable(int id) async => await ((await database)!.delete(tableName));
}
