import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/services/database_service.dart';


class DatabaseRepository {
  
final DatabaseService databaseService;

const DatabaseRepository({required this.databaseService});


 Future<List<NoteModel>> get() async {
   try {
     return await databaseService.fetchData();
   } catch (e) {
     throw Exception('Could not fetch the data $e');
   }
  }

Future<bool> insert(NoteModel noteModel)async{
try {
  return await databaseService.insertData(NoteModel(date: noteModel.date,imagePath: noteModel.imagePath ,title: noteModel.title, subTitle: noteModel.subTitle, description: noteModel.description));
} catch (e) {
 throw Exception('Could not insert $e'); 
}
}

Future<bool> delete(NoteModel notepad,  )async{
try {
  return await databaseService.delete(notepad);
} catch (e) {
  throw Exception('Could not delete $e');
}
}


Future<bool> update(NoteModel notepad)async{

try {
  return await databaseService.updateData(notepad);
} catch (e) {
  throw Exception('Could not update $e');
}

}


}