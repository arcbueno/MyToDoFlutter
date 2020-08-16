import 'package:MyToDoFlutter/database/my_todo_database.dart';
import 'package:MyToDoFlutter/models/to_do.model.dart';
import 'package:sqflite/sqlite_api.dart';

class ToDoDao {
  static const tableName = 'toDo';
  MyToDoDatabase appDb;

  ToDoDao(MyToDoDatabase appDb); // : super(appDb);

  Future<ToDoModel> add(ToDoModel model) async {
    await (await appDb.db).insert(tableName, model.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return model;
  }

  ToDoModel addBatch(ToDoModel model, Batch batch) {
    batch.insert(tableName, model.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return model;
  }

  Future<int> update(ToDoModel model) async {
    return (await appDb.db).update(tableName, model.toDb(),
        where: 'rowid = ?',
        whereArgs: [model.rowid],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ToDoModel updateBatch(ToDoModel model, Batch batch) {
    batch.update(tableName, model.toDb(),
        where: 'rowid = ?',
        whereArgs: [model.rowid],
        conflictAlgorithm: ConflictAlgorithm.fail);
    return model;
  }

  Future<ToDoModel> getById(int id) async {
    if (id == null) return null;
    final Future<List<Map<String, dynamic>>> futureMaps =
        (await appDb.db).query(tableName, where: 'rowid = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return ToDoModel.fromDb(maps.first);
    }

    return null;
  }

  Future<List<ToDoModel>> getAll() async {
    var db = (await appDb.db);
    var res = await db.query(tableName, orderBy: 'rowid');

    if (res.isNotEmpty) {
      var collection = res.map((model) => ToDoModel.fromDb(model)).toList();
      return collection;
    }

    return [];
  }

  Future<void> remove(int rowid) async {
    return (await appDb.db)
        .delete(tableName, where: 'rowid = ?', whereArgs: [rowid]);
  }
}
