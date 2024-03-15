import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'mydb.db';
  static final _databaseVersion = 1;
  static final usersTable = 'users';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $usersTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');
  }

// CRUD operations will be implemented here
  // Create a new user
Future<int> createUser(String name, String email) async {
  Database db = await instance.database;
  return await db.insert(usersTable, {'name': name, 'email': email});
}

// Read all users
Future<List<Map<String, dynamic>>> getAllUsers() async {
  Database db = await instance.database;
  return await db.query(usersTable);
}

// Update a user
Future<int> updateUser(int id, String name, String email) async {
  Database db = await instance.database;
  return await db.update(usersTable, {'name': name, 'email': email},
      where: 'id = ?', whereArgs: [id]);
}

// Delete a user
Future<int> deleteUser(int id) async {
  Database db = await instance.database;
  return await db.delete(usersTable, where: 'id = ?', whereArgs: [id]);
}

}
