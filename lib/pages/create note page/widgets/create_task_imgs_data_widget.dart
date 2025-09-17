import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:provider/provider.dart';

class CreateTaskImgsDataWidget extends StatelessWidget {
  const CreateTaskImgsDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<ImagePickerController>(
        builder:
            (context, value, child) =>
                (value.imgList!.isEmpty)
                    ? const SizedBox()
                    : Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.imgList?.length,
                        itemBuilder:
                            (context, index) => Container(
                              color: Colors.transparent,
                              height: 200,
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.file(
                                      File(value.imgList![index]),
                                      height: 350,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1, -1.2),
                                    child: IconButton(
                                      onPressed: () {
                                        value.removePhoto(index);
                                      },
                                      icon: Icon(Icons.close_sharp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ),
      ),
    );
  }
}
