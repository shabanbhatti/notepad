import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/Widgets/home_card_grid_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/Widgets/home_listtile_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/view_as_gallery_or_list_controller.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_dialog.dart';
import 'package:provider/provider.dart';

class HomeDataWidget extends StatefulWidget {
  const HomeDataWidget({super.key, required this.notepad});

  final List<NoteModel>? notepad;

  @override
  State<HomeDataWidget> createState() => _MywidgetState();
}

class _MywidgetState extends State<HomeDataWidget>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextx) {
    print('MYWIDGET CALLED--------');

    return SliverToBoxAdapter(
      child: Consumer<GalleryOrListProvider>(
        builder: (context, value, child) {
          if (value.isGrid) {
            return Consumer<DatabaseController>(
              builder:
                  (context, value, child){
                    var list= value.searchList;
                    return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    reverse: true,
                    itemCount: list.length,
                    itemBuilder:
                        (context, index) =>
                            Slidable(
                              key: ValueKey(list[index].primaryKey),
                              endActionPane: ActionPane(motion:const ScrollMotion(), children: [
                                Consumer<CheckForDelete>(
                                  builder: (context,value,_) {
                                    return SlidableAction(
                                      backgroundColor: Colors.red,
                                      onPressed: (context){
                                      if (value.isCheck == false) {
                                                      deleteDialog(context, () {
                                                        
                                                          contextx.read<DatabaseController>().delete(list[index]);
                                                        
                                                      },
                                                      
                                                      );
                                                    }
                                    } ,icon: CupertinoIcons.delete, );
                                  }
                                )
                              ]),
                              child: MyListTile(notepad: list[index])),
                  );
                  }
            );
          } else {
            return Consumer<DatabaseController>(
              builder:
                  (context, value, child) => Consumer<CheckForDelete>(
                    builder:
                        (context, checkForDelete, child) => Padding(
                          padding: EdgeInsets.all(11),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: value.searchList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.9,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemBuilder: (context, index) {
                              var myIndex = value.searchList.length - 1 - index;
                              print(checkForDelete.isCheck);
                              return CardWidgetForGrid(
                                isCheck: checkForDelete.isCheck,
                                searchList: value.searchList[myIndex],
                                onDelete: () {
                                  context.read<DatabaseController>().delete(value.searchList[index]);
                                },
                              );
                            },
                          ),
                        ),
                  ),
            );
          }
        },
      ),
    );
  }
}
