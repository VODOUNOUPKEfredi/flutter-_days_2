import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _database;
  //recuperer la base de donnees
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // initialiser la base de donnees
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath());
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE todo (id INTEGER PRIMARY KEY, task TEXT, done INTEGER)',
        );
        //creation de la table user
        await db.execute('''
CREATE TABLE USERS(
id INTEGER PRIMARY KEY AUTOINCREMENT , 
name TEXT UNIQUE ,
balance REAL DEFAULT 1000)

''');

        await db.execute(''' 

CREATE TABLE  Transactions(
id INTEGER PRIMARY KEY AUTOINCREMENT ,

 sender_id INTEGER  ,
 recipient_id INTEGER,
 amount REAL,
 date TEXT,
 is_sender INTEGER CHECK (is_sender IN(0,1)),
 FOREIGN KEY  (user_id) REFERENCES users (id),
 
 )
''');
      },
    );
  }

  // inserer un user
  static Future<int> inserUser(
    String name,
    String email,
    double balance,
  ) async {
    final db = await getDatabase();
    return db.insert('users', {
      "name": name,
      "email": email,
      "balance": balance,
    });
  }

  //obtenir  tous les utilisateur
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await getDatabase();
    return db.query('users');
  }

  // ajouter une transaction en utlisant is_sender
  static Future<void> inserTransactions(
    int sender_id,
    int recipient_id,
    double amount,
  ) async {
    final db = await getDatabase();
    String currentDate = DateTime.now().toString();
    // ajouter une transaction pour un l'expediteur(is_sender =1)

    await db.insert('Transactions', {
      "user_id": sender_id,

      "amount": amount,
      "date": currentDate,
      "is_sender": 1,
    });
    await db.insert('Transactions', {
      "user_id": sender_id,
      "date": currentDate,
      "amount": amount,
      "is_sender": 0,
    });
    // mettre ajour le solde de l'expediteur
    await db.rawUpdate("UPDATE users SET balance = balance -? WERE id =?", [
      amount,
      sender_id,
    ]);
    //mettre a jour le solde du destinataire ou recipient
    await db.rawUpdate("UPDATE users SET balance = balance +? WERE id =?", [
      amount,
      recipient_id,
    ]);
  }

  //obtenir toutes les transactions
  static Future<List<Map<String, dynamic>>> getTransaction() async {
    final db = await getDatabase();
    return db.query('Transactions', orderBy: "date DESC");
  }

  // obtenir le solde d'un user
  Future<double> getUserBalance(userId) async {
    final db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(
      "users",
      columns: ["balance"],
      where: "id =?",
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first["balance"] as double;
    }
    return 0.0; // 0.0 es une valeur pas defaut qui sera renvoyer a la place de null pour eviter une erreur au cas ou l'utlisateur serais pas trouvé
  }
}
