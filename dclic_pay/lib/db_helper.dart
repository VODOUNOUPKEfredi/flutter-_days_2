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
//inserer  permettant d'inserer une task un bool mais avec 1 et 0 ,  1 pour tout c'est bien passer 0 pour le contraire
static Future <int > inser(String task)async{
  final db= await getDatabase();
 return db.insert('todo', {'task':task ,'done':0});
}
// inserer un user
static Future<int> inserUser(String name ,String email, double balance) async{
  final db = await getDatabase();
  return db.insert('users', {
    "name":name,
    "email":email,
    "balance":balance
  });
  //obtenir 
}



}