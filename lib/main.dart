import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/controllers/shake_animaton_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/database_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/img_picker_controller.dart';
import 'package:notepad_app_using_database_sqflite/controllers/is_clicked_for_update.dart';
import 'package:notepad_app_using_database_sqflite/controllers/theme_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/select_for_delete_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/controllers/view_as_gallery_or_list_controller.dart';
import 'package:notepad_app_using_database_sqflite/pages/intro%20Page/intro_page.dart';
import 'package:notepad_app_using_database_sqflite/repository/database_repository.dart';
import 'package:notepad_app_using_database_sqflite/routes/on_generate_route.dart';
import 'package:notepad_app_using_database_sqflite/services/database_service.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  ThemeController darkLightTheme = ThemeController();
  GalleryOrListProvider galleryOrListProvider = GalleryOrListProvider();

  await galleryOrListProvider.getGridOrList();
  await darkLightTheme.getTheme();

  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (context) => DatabaseService(),),
        Provider<DatabaseRepository>(create: (context) => DatabaseRepository(databaseService: context.read<DatabaseService>()),),
        ChangeNotifierProvider(create: (context) => DatabaseController(databaseRepository:context.read<DatabaseRepository>() )),
        ChangeNotifierProvider(create: (context) => galleryOrListProvider),
        ChangeNotifierProvider(create: (context) => darkLightTheme),
        ChangeNotifierProvider(
          create: (context) => IsClickedToShowUpdateProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ImagePickerController()),
        ChangeNotifierProvider(create: (context) => CheckForDelete()),
        ChangeNotifierProvider(create: (context) => ShakeAnimationController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeController>().myTheme,

      debugShowCheckedModeBanner: false,
      initialRoute: IntroPage.pageName,

      onGenerateRoute: onGenerateRoute,
    );
  }
}
