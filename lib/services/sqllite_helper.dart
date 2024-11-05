import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zyra/model/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    // Initialize the database if it hasn't been created yet
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    // Define the path to the database
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create the products table with all necessary fields
        return db.execute(
          'CREATE TABLE products ('
          'id TEXT PRIMARY KEY, '
          'categoryId TEXT, '
          'companyId TEXT, '
          'name TEXT, '
          'image TEXT, '
          'price INTEGER, '
          'stock TEXT, '
          'sizes TEXT, '
          'description TEXT'
          ')',
        );
      },
    );
  }

  Future<void> insertOrUpdateProducts(
      List<Map<String, dynamic>> products) async {
    final db = await database;
    try {
      for (var product in products) {
        await db.insert(
          'products',
          product,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      print("Error inserting or updating products: $e");
      // Optionally handle the error further or throw it
    }
  }

  // Retrieve all products from the database
  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    // Convert each map to a Product object
    return List<Product>.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
}
