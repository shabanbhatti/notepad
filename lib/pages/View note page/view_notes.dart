import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/is_clicked_for_update.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/pages/View%20note%20page/widgets/view_notes_sliver_appbar_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/view%20image%20page/view_image_page.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_photo_dialog.dart';
import 'package:notepad_app_using_database_sqflite/utils/formatted_date_methd.dart';
import 'package:provider/provider.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({super.key, required this.notepad});
  static const pageName = '/view_page';
  final NoteModel? notepad;
  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  var titleFocusNode = FocusNode();
  var subTitleFocusNode = FocusNode();
  var descriptionFocusNode = FocusNode();
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  var descriptionController = TextEditingController();

  DateTime? dateTime;

  // List<String>? imgPath;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DatabaseController>().getNotes();
    });
    Provider.of<ImagePickerController>(
      context,
      listen: false,
    ).equalToNotePadList(widget.notepad!.imagePath!);

    dateTime = DateTime.now();

    titleController.text = widget.notepad!.title.toString();
    subTitleController.text = widget.notepad!.subTitle.toString();
    descriptionController.text = widget.notepad!.description.toString();
  }

  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    scrollController.dispose();
    titleController.dispose();
    subTitleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  // bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    print('VIEW NOTE CALLED--------');

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(20),
        child: CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            MySliverAppBarViewPage(
              notepad: widget.notepad!,
              titleController: titleController,
              subTitleController: subTitleController,
              descriptionController: descriptionController,
              dateTime: dateTime,
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  getFormattedDate(dateTime!),
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      right: 15,
                      left: 15,
                    ),
                    child: Consumer<IsClickedToShowUpdateProvider>(
                      builder:
                          (context, value, child) => TextField(
                            onChanged: (X) {
                              value.viewPageOnChanged();
                            },
                            controller: titleController,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: null,
                            focusNode: titleFocusNode,
                            onSubmitted: (value) {
                              FocusScope.of(
                                context,
                              ).requestFocus(subTitleFocusNode);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Title',

                              hintStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextField(
                      onChanged: (value) {
                        // read.viewPageOnChanged();
                        Provider.of<IsClickedToShowUpdateProvider>(
                          context,
                          listen: false,
                        ).viewPageOnChanged();
                      },
                      controller: subTitleController,
                      focusNode: subTitleFocusNode,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) {
                        FocusScope.of(
                          context,
                        ).requestFocus(descriptionFocusNode);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Subtitle (optional)',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextField(
                      onChanged: (value) {
                        // read.viewPageOnChanged();
                        Provider.of<IsClickedToShowUpdateProvider>(
                          context,
                          listen: false,
                        ).viewPageOnChanged();
                      },
                      controller: descriptionController,
                      focusNode: descriptionFocusNode,
                      style: const TextStyle(fontSize: 15),
                      maxLines: null,

                      decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<ImagePickerController>(
              builder:
                  (context, value, child) =>
                      (value.viewPageList!.isEmpty)
                          ? const SliverToBoxAdapter(child: SizedBox())
                          : imgListViewSliver(value),
            ),
          ],
        ),
      ),
    );
  }

  Widget imgListViewSliver(ImagePickerController value) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverList.builder(
        itemCount: value.viewPageList!.length,
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ViewImage.pageName,
                    arguments:
                        {
                              'notepad': widget.notepad,

                              'index': index,
                              'title': titleController.text,
                              'subTitle': subTitleController.text,
                              'description': descriptionController.text,
                            }
                            as Map<String, dynamic>,
                  );
                },

                onLongPress: () async {
                  deletePhotoDialog(context, () {
                    context
                        .read<ImagePickerController>()
                        .viewPageList!
                        .removeAt(index);

                    context
                        .read<DatabaseController>()
                        .update(
                          NoteModel(
                            primaryKey: widget.notepad!.primaryKey,
                            title: titleController.text,
                            subTitle: subTitleController.text,
                            description: descriptionController.text,
                            date: getFormattedDate(dateTime!),
                            imagePath: value.viewPageList,
                          ),
                          context,
                        )
                        .then((X) {
                          context
                              .read<IsClickedToShowUpdateProvider>()
                              .letToFalse()
                              .then((X) {
                                value.updateState();
                              });
                        });
                  });
                },
                child: Hero(
                  tag: value.viewPageList![index],
                  child: Image.file(
                    File(value.viewPageList![index]),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
