import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:provider/provider.dart';

class CreateTaskSliverAppbarWidget extends StatelessWidget {
  const CreateTaskSliverAppbarWidget({super.key, required this.titleController, required this.subtitleController, required this.descriptionController, });
final TextEditingController titleController;
final TextEditingController subtitleController;
final TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
              // expandedHeight: 100,
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
                        value.isClicked = false;
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.black,
                      ),
                    ),
              ),
              title: const Text(
                'Add new note',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              actions: [
                Consumer<ImagePickerController>(
                  builder:
                      (context, value, child) =>
                          (value.isClicked == false && value.imgList!.isEmpty)
                              ? SizedBox()
                              : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextButton(
                                      onPressed: () {
                                        context.read<DatabaseController>()
                                            .insertNote(
                                              titleController.text.trim(),
                                              subtitleController.text.trim(),
                                              descriptionController.text.trim(),
                                              context
                                                  .read<ImagePickerController>()
                                                  .imgList!,
                                            )
                                            .then((valueX) {
                                              // read.getData().then((value) {
                                              value.imgList!.clear();
                                              Navigator.of(context).pop();
                                              // },);
                                            });
                                      },
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                ),
              ],
              pinned: false,
              snap: true,
              floating: true,
              
            );
  }
}