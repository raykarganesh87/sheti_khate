import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';
import '../models/equipment.dart';
import '../models/chemical.dart';
import '../models/crop.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sheti_khate.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date INTEGER NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE equipment (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        purchase_date INTEGER NOT NULL,
        price REAL NOT NULL,
        description TEXT,
        last_maintenance INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE chemicals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        usage_date INTEGER NOT NULL,
        quantity REAL NOT NULL,
        crop_name TEXT NOT NULL,
        area_covered REAL NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE crops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        planting_date INTEGER NOT NULL,
        harvest_date INTEGER,
        area REAL NOT NULL,
        variety TEXT NOT NULL,
        expected_yield REAL NOT NULL,
        actual_yield REAL NOT NULL,
        notes TEXT
      )
    ''');
  }

  // Expenses CRUD
  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Expense.fromMap(maps[i]));
  }

  // Equipment CRUD
  Future<int> insertEquipment(Equipment equipment) async {
    final db = await database;
    return await db.insert('equipment', equipment.toMap());
  }

  Future<List<Equipment>> getEquipment() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('equipment', orderBy: 'name');
    return List.generate(maps.length, (i) => Equipment.fromMap(maps[i]));
  }

  // Chemicals CRUD
  Future<int> insertChemical(Chemical chemical) async {
    final db = await database;
    return await db.insert('chemicals', chemical.toMap());
  }

  Future<List<Chemical>> getChemicals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chemicals', orderBy: 'usage_date DESC');
    return List.generate(maps.length, (i) => Chemical.fromMap(maps[i]));
  }

  // Crops CRUD
  Future<int> insertCrop(Crop crop) async {
    final db = await database;
    return await db.insert('crops', crop.toMap());
  }

  Future<List<Crop>> getCrops() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('crops', orderBy: 'planting_date DESC');
    return List.generate(maps.length, (i) => Crop.fromMap(maps[i]));
  }
}