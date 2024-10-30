import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 2, // Incrementar la versión aquí
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            cedula TEXT,
            password TEXT,
            role TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE users ADD COLUMN role TEXT
          ''');
        }
      },
    );
  }

  Future<void> insertUser(String name, String email, String cedula,
      String password, String role) async {
    final db = await database;
    await db.insert(
      'users',
      {
        'name': name,
        'email': email,
        'cedula': cedula,
        'password': password,
        'role': role
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> updateUser(int id, String name, String email, String cedula,
      String password, String role) async {
    final db = await database;
    await db.update(
      'users',
      {
        'name': name,
        'email': email,
        'cedula': cedula,
        'password': password,
        'role': role
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
