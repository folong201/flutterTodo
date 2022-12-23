import 'package:folong201todo/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    print("initialisation of db");
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT)");
  }

  Future<Todo> insert(Todo tod) async {
    var dbClient = await db;
    await dbClient?.insert('todo', tod.toMap());
    print("data saved"+tod.toString());
    return tod;
  }

  Future<List<Todo>> getDataList() async {
    await db;
    final List<Map<String, Object?>> Queryresult =
        await _db!.rawQuery('SELECT * FROM todo');
    print('query resutl' + Queryresult.toString());
    return Queryresult.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('todo', where: 'id =?', whereArgs: [id]);
  }

  Future<int> update(Todo Tod) async {
    var dbClient = await db;
    print("updating");
    return dbClient!
        .update('todo', Tod.toMap(), where: 'id = ?', whereArgs: [Tod.id]);
  }
}
