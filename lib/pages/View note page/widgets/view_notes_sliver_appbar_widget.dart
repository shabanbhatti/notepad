import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/is_clicked_for_update.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_dialog.dart';
import 'package:notepad_app_using_database_sqflite/utils/formatted_date_methd.dart';
import 'package:provider/provider.dart';

class MySliverAppBarViewPage extends StatelessWidget {
  const MySliverAppBarViewPage({
    super.key,
    required this.notepad,
    required this.titleController,
    required this.subTitleController,
    required this.descriptionController,
    required this.dateTime,
  });
  final NoteModel notepad;
  final TextEditingController titleController;
  final TextEditingController subTitleController;
  final TextEditingController descriptionController;
  final DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shadowColor: Colors.grey,
      elevation: 1000,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.amber,
      centerTitle: true,
      leading: Consumer<ImagePickerController>(
        builder:
            (context, value, child) => IconButton(
              onPressed: () {
                value.clearList();
                value.viewPageList!.clear();
                context.read<IsClickedToShowUpdateProvider>().letToFalse().then((value) {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(CupertinoIcons.back, color: Colors.black),
            ),
      ),
      title: Text(
        (notepad.title!.isEmpty) ? '(NO TITLE)' : notepad.title.toString(),
        // textDirection: TextDirection.rtl,
        // textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),

      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Consumer<IsClickedToShowUpdateProvider>(
                builder:
                    (context, value, child) => IconButton(
                      color: Colors.black,
                      onPressed: () {
                        showMenu(
                          menuPadding: EdgeInsets.all(0),
                          position: const RelativeRect.fromLTRB(0, 0, -20, 0),
                          context: context,
                          items: [
                            PopupMenuItem(
                              /*
                     
                     */
                              child: Consumer<IsClickedToShowUpdateProvider>(
                                builder:
                                    (context, value, child) => ListTile(
                                      shape: Border(
                                        bottom: BorderSide(
                                          width: 0.5,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      leading: Icon(CupertinoIcons.camera),
                                      title: Text(
                                        'Camera',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        context
                                            .read<ImagePickerController>()
                                            .getImageByCameraForPageView(
                                              context
                                                  .read<ImagePickerController>()
                                                  .viewPageList,
                                            )
                                            .then((valueX) {
                                              value.viewPageOnChanged();
                                              Navigator.pop(context);
                                            });
                                      },
                                    ),
                              ),
                            ),

                            PopupMenuItem(
                              child: Consumer<IsClickedToShowUpdateProvider>(
                                builder:
                                    (context, value, child) => ListTile(
                                      shape: Border(
                                        bottom: BorderSide(
                                          width: 0.5,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      leading: Icon(CupertinoIcons.photo),
                                      title: Text(
                                        'Gallery',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        context
                                            .read<ImagePickerController>()
                                            .getImageByGalleryForPageView(
                                              context
                                                  .read<ImagePickerController>()
                                                  .viewPageList,
                                            )
                                            .then((valueX) {
                                              value.viewPageOnChanged();
                                              // Navigator.pop(context);
                                            });
                                      },
                                    ),
                              ),
                            ),

                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.delete, color: Colors.red),
                                title: Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  deleteDialog(context, () {
                                    Provider.of<DatabaseController>(
                                      context,
                                      listen: false,
                                    ).delete(notepad);
                                    Navigator.pop(context);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      icon: const Icon(CupertinoIcons.ellipsis),
                    ),
              ),
            ),

            Consumer<IsClickedToShowUpdateProvider>(
              builder:
                  (context, value, child) =>
                      (value.isClicked == false)
                          ? const SizedBox()
                          : TextButton(
                            onPressed: () {
                              if (titleController.text.isEmpty &&
                                  subTitleController.text.isEmpty &&
                                  descriptionController.text.isEmpty) {
                                Navigator.of(context).pop();
                              } else {
                                log(titleController.text);
                                context
                                    .read<DatabaseController>()
                                    .update(
                                      NoteModel(
                                        primaryKey: notepad.primaryKey,
                                        title: titleController.text,
                                        subTitle: subTitleController.text,
                                        description: descriptionController.text,
                                        date: getFormattedDate(dateTime!),
                                        imagePath:
                                            context
                                                .read<ImagePickerController>()
                                                .viewPageList,
                                      ),
                                      context,
                                    )
                                    .then((value) {
                                      context
                                          .read<IsClickedToShowUpdateProvider>()
                                          .letToFalse()
                                          .then((value) {
                                            Navigator.pop(context);
                                          });
                                    });
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
            ),
          ],
        ),
      ],

      pinned: false,
      snap: true,
      floating: true,
    );
  }
}
