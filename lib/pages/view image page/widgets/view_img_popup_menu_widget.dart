import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/is_clicked_for_update.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_photo_dialog.dart';
import 'package:notepad_app_using_database_sqflite/utils/formatted_date_methd.dart';
import 'package:provider/provider.dart';

class ViewImgPopupMenuWidget extends StatelessWidget {
  const ViewImgPopupMenuWidget({
    super.key,
    this.pageviewIndex,
    required this.list,
    required this.noteModel,
    required this.dateTime,
  });
  final int? pageviewIndex;
  final List<String> list;
  final NoteModel noteModel;
  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.black,
      onPressed: () {
        showMenu(
          menuPadding: EdgeInsets.all(0),
          position: const RelativeRect.fromLTRB(0, 0, -20, 0),
          context: context,
          items: [
            PopupMenuItem(
              child: ListTile(
                shape: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'Delete photo',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  deletePhotoDialog(context, () async {
                    final safeIndex = (pageviewIndex ?? 0).clamp(
                      0,
                      list.length - 1,
                    );

                    Provider.of<ImagePickerController>(
                      context,
                      listen: false,
                    ).removeAtViewPageList(safeIndex);

                    await context.read<DatabaseController>().update(
                      NoteModel(
                        primaryKey: noteModel.primaryKey,
                        title: noteModel.title,
                        subTitle: noteModel.subTitle,
                        description: noteModel.description,
                        date: getFormattedDate(dateTime),
                        imagePath: list,
                      ),
                      context,
                    );

                    await context
                        .read<IsClickedToShowUpdateProvider>()
                        .letToFalse()
                        .then((X) {
                          context.read<ImagePickerController>().updateState();
                        });

                    context.read<ImagePickerController>().updateState();
                    Navigator.pop(context);

                    if (list.isEmpty) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ),
          ],
        );
      },
      icon: const Icon(CupertinoIcons.ellipsis),
    );
  }
}
