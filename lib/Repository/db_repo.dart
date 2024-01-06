import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test/Model/get_model.dart';

class DbRepo {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE your_table (
            id INTEGER PRIMARY KEY,
            userId INTEGER,
            title TEXT,
            completed INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertData(GetModel data) async {
    final db = await database;
    await db.insert('your_table', data.toJson());
  }

  Future<List<GetModel>> getAllData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('your_table');

    return List.generate(maps.length, (i) {
      return GetModel(
        userId: maps[i]['userId'],
        id: maps[i]['id'],
        title: maps[i]['title'],
        completed: maps[i]['completed'] == 1,  );
    });
  }

  
}
