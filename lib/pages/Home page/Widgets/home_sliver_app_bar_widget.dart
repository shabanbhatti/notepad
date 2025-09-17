import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/shake_animaton_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/theme_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/view_as_gallery_or_list_controller.dart';
import 'package:notepad_app_using_database_sqflite/theme/theme.dart';
import 'package:notepad_app_using_database_sqflite/utils/dialog%20boxes/delete_all_notes_dialog.dart';
import 'package:notepad_app_using_database_sqflite/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class MySliverAppBar extends StatefulWidget {
  const MySliverAppBar({super.key});

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<ShakeAnimationController>().myAnimation(this);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      elevation: 1000,
      shadowColor: Colors.black,

      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<CheckForDelete>(
              builder:
                  (context, value, child) => Consumer<DatabaseController>(
                    builder: (context, providerForDatabase, child) {
                      if (providerForDatabase.isLoaded) {
                        return (providerForDatabase.notepad.isNotEmpty)
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                (value.isSelected == true)
                                    ? SlideTransition(
                                      position:
                                          context
                                              .read<ShakeAnimationController>()
                                              .slide,
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<CheckForDelete>()
                                              .selectButton();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                    : SlideTransition(
                                      position:
                                          context
                                              .read<ShakeAnimationController>()
                                              .slide,
                                      child: TextButton(
                                        onPressed: () {
                                          deleteMultipleItemDialog(context, () {
                                            for (var element
                                                in value.selecteditemList!) {
                                              context
                                                  .read<DatabaseController>()
                                                  .delete(element)
                                                  .then((valueX) {
                                                    Provider.of<CheckForDelete>(
                                                      context,
                                                      listen: false,
                                                    ).afterDelete(context);
                                                  });
                                            }
                                          });
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            )
                            : SizedBox();
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
            ),

            // ----------------------------------------------------
            Consumer<CheckForDelete>(
              builder:
                  (context, value, child) =>
                      (value.isSelected == true && value.isCheck == false)
                          ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                showMenu(
                                  menuPadding: EdgeInsets.all(0),
                                  position: const RelativeRect.fromLTRB(
                                    0,
                                    0,
                                    -20,
                                    0,
                                  ),
                                  context: context,
                                  items: [
                                    PopupMenuItem(
                                      child: ListTile(
                                        shape: Border(
                                          bottom: BorderSide(
                                            width: 0.5,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        leading:
                                            Consumer<GalleryOrListProvider>(
                                              builder:
                                                  (context, value, child) =>
                                                      Icon(
                                                        (value.isGrid)
                                                            ? Icons.apps
                                                            : Icons.view_list,
                                                      ),
                                            ),
                                        title: Consumer<GalleryOrListProvider>(
                                          builder:
                                              (context, value, child) => Text(
                                                'View as ${value.viewAs}',
                                              ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<GalleryOrListProvider>()
                                              .listOrGrid();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: ListTile(
                                        leading: Consumer<ThemeController>(
                                          builder:
                                              (context, value, child) => Icon(
                                                (value.currentTheme ==
                                                        lightTheme)
                                                    ? Icons.dark_mode
                                                    : Icons.light_mode,
                                              ),
                                        ),
                                        title: Consumer<ThemeController>(
                                          builder:
                                              (context, value, child) => Text(
                                                (value.currentTheme ==
                                                        lightTheme)
                                                    ? 'Dark mode'
                                                    : 'Light mode',
                                              ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<ThemeController>()
                                              .toggled();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              icon: const Icon(CupertinoIcons.ellipsis),
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextButton(
                              onPressed: () {
                                Provider.of<CheckForDelete>(
                                  context,
                                  listen: false,
                                ).afterDelete(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
            ),
          ],
        ),
      ],

      expandedHeight: MediaQuery.of(context).size.height * 0.2,
      backgroundColor: Colors.amber,
      snap: true,
      pinned: true,
      floating: true,
      title: const Text(
        'Notepad',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Consumer<DatabaseController>(
                builder:
                    (context, value, child) =>
                        (value.isLoaded)
                            ? Center(
                              child: CustomTextfield(
                                controller: searchController,
                                onFunction: (valueController) {
                                  context
                                      .read<DatabaseController>()
                                      .searchOnChanged(
                                        valueController,
                                        value.notepad,
                                      );
                                },
                              ),
                            )
                            : TextField(
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black),

                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),

                                label: const Text(
                                  'Search',
                                  style: TextStyle(color: Colors.black),
                                ),

                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 152, 116, 9),
                                  ),
                                ),
                              ),
                            ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}
