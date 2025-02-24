import 'dart:core';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:dclic_pay/user.dart';

class DbHelper {
  static Database? _database;

  // ✅ Initialisation de la base de données
  static Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  // ✅ Configuration et création de la base de données
  static Future<Database> _initDatabase() async {
    sqfliteFfiInit(); // ✅ Initialise l'environnement FFI
    databaseFactory = databaseFactoryFfi; // ✅ Active la factory pour SQLite FFI

    String path = join(await getDatabasesPath(), 'dclic_pay.db');
    return await databaseFactory.openDatabase(path, options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        // Création de la table USERS
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT UNIQUE,
            email TEXT UNIQUE,
            balance REAL DEFAULT 1000
          )
        ''');

        // Création de la table TRANSACTIONS
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sender_id INTEGER,
            recipient_id INTEGER,
            amount REAL,
            date TEXT,
            is_sender INTEGER CHECK (is_sender IN (0,1)),
            FOREIGN KEY (sender_id) REFERENCES users(id),
            FOREIGN KEY (recipient_id) REFERENCES users(id)
          )
        ''');
      },
    ));
  }

  // ✅ Ajouter un utilisateur
  static Future<int> insertUser(String name, String email, double balance) async {
    final db = await getDatabase();
    return await db.insert('users', {
      "name": name,
      "email": email,
      "balance": balance,
    });
  }

  // ✅ Obtenir tous les utilisateurs
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await getDatabase();
    return await db.query('users');
  }

  // ✅ Obtenir un utilisateur par email
  static Future<User?> getUserByEmail(String email) async {
    final db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // ✅ Ajouter une transaction
  static Future<void> insertTransaction(int senderId, int recipientId, double amount) async {
    final db = await getDatabase();
    String currentDate = DateTime.now().toIso8601String();

    // Transaction pour l'expéditeur
    await db.insert('transactions', {
      "sender_id": senderId,
      "recipient_id": recipientId,
      "amount": amount,
      "date": currentDate,
      "is_sender": 1,
    });

    // Transaction pour le destinataire
    await db.insert('transactions', {
      "sender_id": senderId,
      "recipient_id": recipientId,
      "amount": amount,
      "date": currentDate,
      "is_sender": 0,
    });

    // Mettre à jour le solde de l'expéditeur
    await db.rawUpdate("UPDATE users SET balance = balance - ? WHERE id = ?", [amount, senderId]);

    // Mettre à jour le solde du destinataire
    await db.rawUpdate("UPDATE users SET balance = balance + ? WHERE id = ?", [amount, recipientId]);
  }

  // ✅ Obtenir toutes les transactions
  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await getDatabase();
    return await db.query('transactions', orderBy: "date DESC");
  }

  // ✅ Obtenir le solde d'un utilisateur
  static Future<double> getUserBalance(int userId) async {
    final db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(
      "users",
      columns: ["balance"],
      where: "id = ?",
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first["balance"] as double;
    }
    return 0.0;
  }

  static getTransaction() {}
}