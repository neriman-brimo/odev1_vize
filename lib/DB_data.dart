import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
//*** database yolu/linki oluşturur ***
    String databasepath = await getDatabasesPath();
//*** database adlandırmak ve  yola/linke eklemek ***
    String path = join(databasepath, 'flutter_assistant.db');
//*** önceki isim ve yol kullanarak database oluşturmak ***
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
//*** metodun sonucu oluşturulan veritabanı döndür ****
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "notes" 
("id" INTEGER not null PRIMARY KEY autoincrement, "görev" TEXT not null ,"durum" BOOLEAN not null)
''');
    print('Create database and tables -------------------------------------');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  CountData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
}
