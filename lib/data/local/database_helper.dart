import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/customer.dart';

class DatabaseHelper {
  // Singleton pattern (only one DB instance in app)
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  /// Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('customer.db');
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Create table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        name TEXT NOT NULL,
        product TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        total REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  /// INSERT customer
  Future<int> insertCustomer(Customer customer) async {
    final db = await instance.database;

    return await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// GET all customers
  Future<List<Customer>> getAllCustomers() async {
    final db = await instance.database;

    final result = await db.query('customers', orderBy: 'date DESC');

    return result.map((map) => Customer.fromMap(map)).toList();
  }

  /// UPDATE customer
  Future<int> updateCustomer(Customer customer) async {
    final db = await instance.database;

    return await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  /// DELETE customer
  Future<int> deleteCustomer(int id) async {
    final db = await instance.database;

    return await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// CLOSE database (optional)
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}