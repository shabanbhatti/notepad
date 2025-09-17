import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/shake_animaton_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/pages/View%20note%20page/view_notes.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_dialog.dart';
import 'package:provider/provider.dart';

class CardWidgetForGrid extends StatelessWidget {
  const CardWidgetForGrid({
    super.key,
    required this.searchList,
    required this.onDelete,
    required this.isCheck
  });
  final NoteModel searchList;
  final void Function() onDelete;
  final bool isCheck;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onLongPress: () {
            if (isCheck == false) {
              deleteDialog(context, (){
                onDelete();
              },);
            }
          },
          onTap:
              (isCheck == false)
                  ? () {
                    Navigator.of(
                      context,
                    ).pushNamed(ViewNotes.pageName, arguments: searchList);
                  }
                  : () {
                    context.read<ShakeAnimationController>().runShakeWithTimer();
                  },

          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.note,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 30,
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Consumer<CheckForDelete>(
                        builder: (context, valueZ, child) {
                          bool isIn = valueZ.selecteditemList!.contains(
                            searchList,
                          );

                          return (valueZ.isCheck == false)
                              ? const SizedBox()
                              : Checkbox(
                                value: isIn,

                                activeColor: Colors.amber,
                                onChanged: (valueX) {
                                
                                  if (valueX == true) {
                                    valueZ.selected(searchList);
                                  } else {
                                    valueZ.removeNote(searchList);
                                  }
                                },
                              );
                        },
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: [
                      Text(
                        (searchList.title!.isNotEmpty)
                            ? searchList.title!
                            : '(NO TITLE)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      Text(
                        (searchList.description!.isNotEmpty)
                            ? searchList.description.toString()
                            : '(NO DESCRIPTION)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 134, 134, 134),
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  searchList.date.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        );
  }
}
