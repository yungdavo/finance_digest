import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final Database? db;

  // Pass a Database instance for testing, or null to use the default database
  DatabaseHelper({this.db});

  static Database? _database;

  // Use the provided database or create a new one
  Future<Database> get database async {
    if (db != null) return db!; // Use the injected database if provided
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT,
            lastName TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertUser(String firstName, String lastName) async {
    final db = await database;
    await db.insert(
      'User',
      {'firstName': firstName, 'lastName': lastName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
