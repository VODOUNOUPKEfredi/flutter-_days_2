import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';


class DbHelper {

static Database ? _database;
//recuperer la base de donnees
static Future <Database> getDatabase() async{
  if( _database!=null )
  return _database!;
  _database=await _initDatabase();
  return _database!;
}
// initialiser la base de donnees
static Future<Database> _initDatabase() async{
  String path = join( await getDatabasesPath());
  return await openDatabase(
    path,
    version: 1,
    onCreate:(db,version) async{
      await db.execute(
        
        'CREATE TABLE todo (id INTEGER PRIMARY KEY, task TEXT, done INTEGER)'
      );
      //creation de la table user
      await db.execute(
        '''
CREATE TABLE USERS(
id INTEGER PRIMARY KEY AUTOINCREMENT , 
name TEXT UNIQUE ,
balance REAL DEFAULT 1000)

'''
      );

      await db.execute(
       ''' 

CREATE TABLE USERS(
id INTEGER PRIMARY KEY AUTOINCREMENT ,

 sender_id INTEGER  ,
 recipient_id INTEGER,
 amount REAL,
 date TEXT,
 FOREIGN KEY  (sender_id) REFERENCES users (id),
 FOREIGN KEY  (recipient_id) REFERENCES users (id),
 )
'''
      );
    } ,
    
  );
}

// inserer un user
static Future<int> inserUser(String name ,String email, double balance) async{
  final db = await getDatabase();
  return db.insert('users', {
    "name":name,
    "email":email,
    "balance":balance
  });
  
  
}
//obtenir  tous les utilisateur
static Future <List<Map<String ,dynamic>>> getUsers()async{
  final db= await getDatabase();
  return db.query('users');
}
// ajouter une transaction
static Future inserTransaction(int sender_id,int recipient_id,double amount)async{
final db= await getDatabase();
return db.insert('Transaction', 
{
  "sender_id":sender_id,
  "recipient_id":recipient_id,
  "amount":amount
});
}
//obtenir toutes les transactions 
static Future <List<Map<String,dynamic>>> getTransaction() async{
  final db= await getDatabase();
  return db.query('Transactions' ,orderBy: "date DESC");
}



}