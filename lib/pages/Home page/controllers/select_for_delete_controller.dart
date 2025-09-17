import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';

class CheckForDelete extends ChangeNotifier {
  bool isCheck = false;

  bool isSelected = true;
  List<NoteModel>? selecteditemList = [];

  Future<void> selectButton() async {
    isCheck = !isCheck;

    if (isCheck == true) {
      selecteditemList!.clear();
    }
    notifyListeners();
  }


// void makeSelectedTrueAndIsCheckedFalse(){

// isSelected=true;
// isCheck=false;
// notifyListeners();

// }

  Future<void> selected(NoteModel notepad) async {
    isSelected = false;
    selecteditemList!.add(notepad);

    // selecteditemList!.clear();

    notifyListeners();
  }

  Future<void> removeNote(NoteModel notepad) async {
    selecteditemList!.remove(notepad);
    if (selecteditemList!.isEmpty) {
      isSelected = true;
    }
    // selecteditemList!.clear();
    notifyListeners();
  }



  Future<void> afterDelete(BuildContext context)async{
 isSelected = true;
                                              isCheck = false;
                                              
                                              notifyListeners();


                                              

  }
}
