import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:apati_paseo_perro/features/walks/domain/models/walk_model.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('walks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE walks ( 
  id $idType, 
  startTime $textType,
  endTime $textType,
  notes $textType
  )
''');
  }

  Future<Walk> create(Walk walk) async {
    final db = await database;
    await db.insert('walks', walk.toJson());
    return walk;
  }

  Future<Walk> read(String id) async {
    final db = await database;
    final maps = await db.query(
      'walks',
      columns: ['id', 'startTime', 'endTime', 'notes'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Walk.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Walk>> readAll() async {
    final db = await database;
    const orderBy = 'startTime DESC';
    final result = await db.query('walks', orderBy: orderBy);

    return result.map((json) => Walk.fromJson(json)).toList();
  }

  Future<int> update(Walk walk) async {
    final db = await database;
    return db.update(
      'walks',
      walk.toJson(),
      where: 'id = ?',
      whereArgs: [walk.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await database;
    return await db.delete(
      'walks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
