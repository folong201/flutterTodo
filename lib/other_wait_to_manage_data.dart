// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:folong201todo/model.dart';
// // import 'package:todo/main.dart';

// class Controller {
//   late Database _database;
//   Future openDb() async {
//     _database = await openDatabase(join(await getDatabasesPath(), "tododb.db"),
//         version: 1, onCreate: (Database db, int version) async {
//       await db.execute(
//         "CREATE TABLE todo(id INTEGER PRIMARY KEY autoincrement, title TEXT, description TEXT)",
//       );
//     });
//     return _database;
//   }

//   insertModel(Todo model) async {
//     await openDb();
//     return await _database.insert('todo', model.toJson());
//   }

//   Future  create(title, description) async {
//     print('creation');
//     var to = new Todo(title: title, description: description);
//     insertModel(to);
//     Get.toNamed('/home');
//     // Get.back();
//     Get.snackbar('success', "it created");
//   }

//   Future <List<Todo>>  getModelList() async {
//     await openDb();
//     var maps = await _database.query('todo');
//     List tab = [];
//     print(maps);
//     return List.generate(maps.length, (i) {
//       var productMap = {
//         'id': maps[i]['id'],
//         'title': maps[i]['title'],
//         'description': maps[i]['description'],
//       };
//       // tab.add(productMap);
//       var tod = Todo(
//           title: maps[i]['title'], description: maps[i]['description']);
//       tod.id = maps[i]['id'];
//       return tod;
//     });

//     // return xx;
//   }

//   delete(int id) async {
//     await openDb();
//     var res = await _database.delete("todo", where: "id = ?", whereArgs: [id]);
//     Get.snackbar("success", '$id Delete successfuly');
//   }

//   Future<int> updateModel(Todo todo) async {
//   await openDb();
//   return await _database.update('todo', todo.toJson(),
//       where: "id = ?", whereArgs: [todo.id]);
// }
// }
