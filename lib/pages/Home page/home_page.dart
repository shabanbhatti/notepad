import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/Widgets/home_data_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/Widgets/home_loading_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/Widgets/home_no_data_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/Widgets/home_sliver_app_bar_widget.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/view_as_gallery_or_list_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/create%20note%20page/create_task_page.dart';
import 'package:notepad_app_using_database_sqflite/widgets/custom_floating_action_btn.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const pageName = '/home_screen';
  @override
  State<HomePage> createState() => _HomeNotepadState();
}

class _HomeNotepadState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DatabaseController>().getNotes();
    });
  }

 

  @override
  Widget build(BuildContext context) {
    print('HOME CALLED--------');

    return Scaffold(
      floatingActionButton: Consumer<CheckForDelete>(
        builder:
            (context, value, child) =>
                (value.isCheck == false)
                    ? CustomFloatingActionBtn(
                      icon: Icons.note_add_rounded,
                      onTap:
                          () => Navigator.of(
                            context,
                          ).pushNamed(CreateTaskPge.pageName),
                    )
                    :const SizedBox(),
      ),
      body: Center(
        child: Consumer<DatabaseController>(
          builder:
              (context, value, child) => CustomScrollView(
                physics: BouncingScrollPhysics(),

                slivers: [
                  MySliverAppBar(),

                  if (value.isLoading)
                    SliverToBoxAdapter(
                      child: Consumer<GalleryOrListProvider>(
                        builder:
                            (context, value, child) =>
                                HomeLoadingWidget(isGrid: value.isGrid),
                      ),
                    ),
                  if (value.isLoaded)
                    (value.notepad.isEmpty)
                        ? const HomeNoDataWidget()
                        : HomeDataWidget(notepad: value.notepad),
                ],
              ),
        ),
      ),
    );
  }
}
