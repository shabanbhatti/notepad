import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/shake_animaton_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/pages/View%20note%20page/view_notes.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_dialog.dart';
import 'package:provider/provider.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.notepad});

  final NoteModel? notepad;

  @override
  Widget build(BuildContext context) {
    print('List tile widget called--------');
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Consumer<CheckForDelete>(
        builder:
            (context, checkForDelete, child) => InkWell(
              onTap:
                  (checkForDelete.isCheck == false)
                      ? () {
                        Navigator.of(
                          context,
                        ).pushNamed(ViewNotes.pageName, arguments: notepad);
                      }
                      : () {
                        context.read<ShakeAnimationController>().runShakeWithTimer();
                      },
              onLongPress: () {
                if (checkForDelete.isCheck == false) {
                  deleteDialog(context, () {
                    context.read<DatabaseController>().delete(notepad!);
                  });
                }
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.note,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                shape: const Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
                title: Text(
                  (notepad!.title!.isNotEmpty) ? notepad!.title! : '(NO TITLE)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  (notepad!.description!.isNotEmpty)
                      ? notepad!.description.toString()
                      : '(NO DESCRIPTION)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 137, 137, 137),
                  ),
                ),
                trailing: Consumer<CheckForDelete>(
                  builder: (context, value, child) {
                    bool isIn = value.selecteditemList!.contains(notepad);

                    return (value.isCheck == false)
                        ? Text(notepad!.date.toString())
                        : Checkbox(
                          value: isIn,
                          activeColor: Colors.amber,
                          onChanged: (valueX) {
                            if (valueX == true) {
                              context.read<CheckForDelete>().selected(notepad!);
                            } else {
                              context.read<CheckForDelete>().removeNote(
                                notepad!,
                              );
                            }
                          },
                        );
                  },
                ),
              ),
            ),
      ),
    );
  }
}
