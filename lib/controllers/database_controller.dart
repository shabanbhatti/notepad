import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/repository/database_repository.dart';
import 'package:notepad_app_using_database_sqflite/utils/formatted_date_methd.dart';

class DatabaseController extends ChangeNotifier {
  final DatabaseRepository databaseRepository;
  DatabaseController({required this.databaseRepository});
  List<NoteModel> searchList = [];
  List<NoteModel> notepad = [];
  DateTime? dateTime;
  bool isLoading = false;
  bool initialPage = true;
  bool isLoaded = false;
  bool isError = false;
  String error = '';

  // ------------GET
  Future<void> getNotes() async {
    try {
      initialPage = false;
      isLoading = true;
      notifyListeners();
      notepad = await databaseRepository.get();
      searchList = notepad;
      isLoading = false;
      isLoaded = true;
      notifyListeners();
    } catch (e) {
      initialPage = false;
      isLoading = false;
      isLoaded = false;
      isError = true;
      error = e.toString();
      notifyListeners();
    }
  }

  // ---------INSERT
  Future<void> insertNote(
    String title,
    String subTitle,
    String description,
    List<String>? imgPath,
  ) async {
    try {
      dateTime = DateTime.now();
      initialPage = false;
      isLoading = true;
      notifyListeners();

      var isInserted = await databaseRepository.insert(
        NoteModel(
          date: getFormattedDate(dateTime!),
          imagePath: imgPath,
          title: title,
          subTitle: subTitle,
          description: description,
        ),
      );

      if (isInserted) {
        isLoading = false;
        isLoaded = true;

        await getNotes();
      }
      notifyListeners();
    } catch (e) {
      initialPage = false;
      isLoading = false;
      isLoaded = false;
      isError = true;
      error = e.toString();
      notifyListeners();
    }
  }

  // --------SEARCH ON CHANGED
  void searchOnChanged(String value, List<NoteModel> data) {
    searchList =
        data
            .where(
              (note) =>
                  note.title!.toLowerCase().contains(value.toLowerCase()) ||
                  (note.subTitle?.toLowerCase().contains(value.toLowerCase()) ??
                      false) ||
                  note.description!.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
    notifyListeners();
  }

  // ---------DELETE
  Future<void> delete(NoteModel notepad) async {
    try {
      initialPage = false;
      isLoading = true;
      notifyListeners();
      var deletNote = await databaseRepository.delete(notepad);

      if (deletNote) {
        searchList.removeWhere((item) => item.primaryKey == notepad.primaryKey);
        isLoading = false;
        isLoaded = true;
        await getNotes();
      }
      notifyListeners();
    } catch (e) {
      initialPage = false;
      isLoading = false;
      isLoaded = false;
      isError = true;
      error = e.toString();
      notifyListeners();
    }
  }

  // ---------UPDATE
  Future<void> update(NoteModel notepad, BuildContext context) async {
    try {
      initialPage = false;
      isLoading = true;
      notifyListeners();
      var isUpdated = await databaseRepository.update(notepad);

      if (isUpdated) {
        await getNotes();
        isLoading = false;
        isLoaded = true;
      }
      notifyListeners();
    } catch (e) {
      initialPage = false;
      isLoading = false;
      isLoaded = false;
      isError = true;
      error = e.toString();
      notifyListeners();
    }
  }
}


