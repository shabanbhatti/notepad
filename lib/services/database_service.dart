import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  
static DatabaseService? myDatabase;

DatabaseService._();

factory DatabaseService(){

 myDatabase ??=DatabaseService._();
return myDatabase!;
}


Future<Database> get database async{

var path =await getDatabasesPath();

return  await openDatabase(join(path, 'userdata.db'), onCreate: (db, version) {
  db.execute(NoteModel.CREATE_TABLE,);
}, version: 1);

}

Future<List<NoteModel>> fetchData()async{

var db= await database;

List data =await db.query(NoteModel.table_name);
return data.map((e) => NoteModel.fromMap(e),).toList();
}


Future<bool> insertData(NoteModel notepad)async{

var db= await database;

var rowEff=await db.insert(NoteModel.table_name, notepad.toMap());
return rowEff>0;
}


Future<bool> delete(NoteModel notepad)async{

var db= await database;

var rowEff= await db.delete(NoteModel.table_name, where: '${NoteModel.col_key}=?', whereArgs: [notepad.primaryKey]);

return rowEff>0;
}

Future<bool> updateData(NoteModel notepad)async{

var db= await database;

var rowEff = await db.update(NoteModel.table_name, notepad.toMap(), where: '${NoteModel.col_key}=?', whereArgs: [notepad.primaryKey]);
print('$rowEff------------');
return rowEff>0;
}


}