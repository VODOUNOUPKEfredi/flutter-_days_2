import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Classe DbHelper
class DbHelper {
  static Database? _database;

  // Méthode pour obtenir la base de données
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDb();
    return _database!;
  }

  // Initialisation de la base de données
  static Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // Création des tables
      await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomEnvoyeur TEXT,
        montant REAL,
        date TEXT
      )
      ''');

      await db.execute('''
      CREATE TABLE solde(
        id INTEGER PRIMARY KEY,
        solde REAL
      )
      ''');

      // Table pour les utilisateurs
      await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        motdepasse TEXT
      )
      ''');
    });
  }

  // Insertion d'un utilisateur
  static Future<int> insertUser(String email, String motdepasse, double d) async {
    final db = await database;
    var result = await db.insert(
      'users',
      {
        'email': email,
        'motdepasse': motdepasse,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Remplacer si l'email existe déjà
    );
    return result;
  }

  // Récupérer un utilisateur par email
  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    var result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null; // Aucun utilisateur trouvé
  }

  // Méthode statique pour récupérer les transactions
  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database;
    return await db.query('transactions');
  }

  // Méthode statique pour récupérer le solde
  static Future<double> getSolde() async {
    final db = await database;
    var result = await db.query('solde');
    if (result.isNotEmpty) {
      return result.first['solde'] as double;
    } else {
      return 0.0;
    }
  }
}