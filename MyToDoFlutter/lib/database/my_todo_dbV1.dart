import 'package:MyToDoFlutter/database/my_todo_database.dart';
import 'package:sqflite/sqflite.dart';

class MyToDoDbV1 extends MyToDoDatabaseBase {
  static void onCreate(Batch batch) {
    _createStockCode(batch);
  }

  static void _createStockCode(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS toDo;');
    batch.execute('''
 CREATE TABLE toDo(
rowid INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT,
body TEXT,
done INTEGER);
''');
  }
}
