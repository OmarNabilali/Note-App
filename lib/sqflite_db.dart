import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqfLiteDb{
static Database? _database;
Future<Database?> get db async{
  if(_database==null){
    _database=await sqfDb();
    return _database;
  }else{
    return _database;
  }
}
  sqfDb()async{

  String path= await getDatabasesPath();
  String collection=await join(path,'omar.db');
  Database name=await openDatabase(collection,onCreate: _onCreate,version: 5,onUpgrade: _onUpgrade);
  return name;

  }
  _onUpgrade(Database database,int oldVersion,int newVersion){
    database.execute('''
CREATE TABLE "products"(
"id" INTEGER PRIMARY KEY  AUTOINCREMENT,
"nameProduct" TEXT NOT NULL)
''');
    print('OnUpgrade =============');

  }

  _onCreate(Database dataBase,int number){  //  يتم استدعائها مره واحده فقط
dataBase.execute('''
CREATE TABLE "notes"(
"id" INTEGER PRIMARY KEY  AUTOINCREMENT,
"name" TEXT NOT NULL,
"note" TEXT NOT NULL
)
''');



print('OnCreate =============');

  }
  //select
  selectData(String sql)async{
  Database? dbs =await db;
  List<Map> response=await dbs!.rawQuery(sql);
  return response;


  }


  //insert
insertData(String note, String name)async{
  Database? dbs =await db;
  int response=await dbs!.rawInsert('INSERT INTO notes( name,note) VALUES( ?,?)',
    [ name,note],);
  return response;
}

// Delete
deleteData(String sql)async{
  Database? dbs =await db;
  Future<int> response=dbs!.rawDelete(sql);
  return response;
}

  updateData(String sql)async{
    Database? dbs =await db;
    Future<int> response=dbs!.rawUpdate(sql);
    return response;
  }


}