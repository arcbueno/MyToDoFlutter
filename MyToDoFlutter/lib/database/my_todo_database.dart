import 'package:MyToDoFlutter/database/my_todo_dbV1.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyToDoDatabase {
  static final MyToDoDatabase _instance = MyToDoDatabase._();
  static Database _database;

  MyToDoDatabase._();

  factory MyToDoDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  Future<String> _databasePath() async {
    return join(await getDatabasesPath(), 'mytodo_database.db');
  }

  Future<Database> init() async {
    var database = openDatabase(
      await _databasePath(),
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    return database;
  }

  void _onCreate(Database db, int version) async {
    var batch = db.batch();
    MyToDoDbV1.onCreate(batch);
    await batch.commit();
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    await batch.commit();
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }

  Future recreateDb() async {
    // Fechando conexões
    await closeDb();
    // Delete the database
    await deleteDatabase(await _databasePath());
    _database = await init();
  }
}

abstract class MyToDoDatabaseBase {
  static void onCreate(Batch batch) {}

  static void onUpgrade(Batch batch) {
    onCreate(batch);
  }
}
