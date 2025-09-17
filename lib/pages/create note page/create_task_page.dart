import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/create%20note%20page/widgets/create_task_imgs_data_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/create%20note%20page/widgets/create_task_sliver_appbar_widget.dart';
import 'package:provider/provider.dart';

class CreateTaskPge extends StatefulWidget {
  const CreateTaskPge({super.key});
  static const pageName = '/edit_or_create';

  @override
  State<CreateTaskPge> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPge> {
  ScrollController scrollController = ScrollController();
  var titleFocusNode = FocusNode();
  var subTitleFocusNode = FocusNode();
  var descriptionFocusNode = FocusNode();
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ImagePickerController>().clearList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    titleController.dispose();
    subTitleController.dispose();
    descriptionController.dispose();
    titleFocusNode.dispose();
    subTitleFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('EDIT OR CREATE CALLED--------');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Scrollbar(
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(20),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            CreateTaskSliverAppbarWidget(
              titleController: titleController,
              subtitleController: subTitleController,
              descriptionController: descriptionController,
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<ImagePickerController>().getImage();
                          },
                          icon: const Icon(CupertinoIcons.photo),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<ImagePickerController>()
                                .getImageByCamera();
                          },
                          icon: const Icon(CupertinoIcons.camera),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 0, right: 15, left: 15),
                    child: TextField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: null,
                      focusNode: titleFocusNode,
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(subTitleFocusNode);
                      },
                      onChanged: (value) {
                        context.read<ImagePickerController>().onChanged(value);
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Title',

                        hintStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextField(
                      controller: subTitleController,
                      focusNode: subTitleFocusNode,
                      onChanged: (value) {
                        context.read<ImagePickerController>().onChanged(value);
                      },
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
                      controller: descriptionController,
                      focusNode: descriptionFocusNode,
                      onChanged: (value) {
                        context.read<ImagePickerController>().onChanged(value);
                      },
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
            const CreateTaskImgsDataWidget(),
          ],
        ),
      ),
    );
  }
}
