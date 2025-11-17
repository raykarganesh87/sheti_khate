import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';
import '../models/equipment.dart';
import '../models/chemical.dart';
import '../models/crop.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;
  
  DatabaseService._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'sheti_khate.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        date INTEGER NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        description TEXT
      )
    ''');
    
    await db.execute('''
      CREATE TABLE equipment (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        purchaseDate INTEGER NOT NULL,
        cost REAL NOT NULL,
        status TEXT,
        notes TEXT
      )
    ''');
    
    await db.execute('''
      CREATE TABLE chemicals (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        purpose TEXT,
        expiryDate INTEGER
      )
    ''');
    
    await db.execute('''
      CREATE TABLE crops (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        soilType TEXT,
        area REAL NOT NULL,
        plantingDate INTEGER NOT NULL,
        expectedHarvest INTEGER,
        status TEXT
      )
    ''');
  }

  // CRUD Operations for Expenses
  Future<int> addExpense(Expense expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) => Expense.fromMap(maps[i]));
  }

  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return await db.update('expenses', expense.toMap(), where: 'id = ?', whereArgs: [expense.id]);
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
