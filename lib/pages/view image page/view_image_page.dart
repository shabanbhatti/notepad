import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/pages/view%20image%20page/widgets/view_img_popup_menu_widget.dart';
import 'package:provider/provider.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({
    super.key,
    required this.index,
    required this.notepad,
    required this.title,
    required this.subTitle,
    required this.description,
  });
  static const pageName = '/view_image';

  final int index;
  final String title;
  final String subTitle;
  final String description;
  final NoteModel notepad;
  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  PageController? pageController;
  DateTime? dateTime;
  @override
  void initState() {
    super.initState();

    Provider.of<ImagePickerController>(
      context,
      listen: false,
    ).currentPageViewIndexEqualToClickPhotoIndex(widget.index);

    dateTime = DateTime.now();
    pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Colors.black),
        ),

        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Consumer<ImagePickerController>(
                  builder:
                      (context, value, child) => ViewImgPopupMenuWidget(
                        list: value.viewPageList ?? [],
                        noteModel: widget.notepad,
                        dateTime: dateTime!,
                        pageviewIndex: value.currentPageViewBuilderINDEX,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<ImagePickerController>(
                builder:
                    (context, value, child) => PageView.builder(
                      onPageChanged: (x) {
                        Provider.of<ImagePickerController>(
                          context,
                          listen: false,
                        ).onChangedPageViewBuilder(x);
                        print('FUCK YOU--------------------');
                      },
                      controller: pageController,
                      physics: BouncingScrollPhysics(),
                      itemCount: value.viewPageList!.length,
                      itemBuilder:
                          (context, index) => Hero(
                            tag: value.viewPageList![index],
                            child: InteractiveViewer(
                              maxScale: 4.0,
                              minScale: 1.0,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.file(
                                  File(value.viewPageList![index]),
                                ),
                              ),
                            ),
                          ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
