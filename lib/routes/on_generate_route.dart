import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/models/note_model.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/home_page.dart';
import 'package:notepad_app_using_database_sqflite/pages/intro%20Page/intro_page.dart';
import 'package:notepad_app_using_database_sqflite/pages/view%20image%20page/view_image_page.dart';
import 'package:notepad_app_using_database_sqflite/pages/View%20note%20page/view_notes.dart';
import 'package:notepad_app_using_database_sqflite/pages/create%20note%20page/create_task_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings rs) {
  switch (rs.name) {
    case IntroPage.pageName:
      return MaterialPageRoute(builder: (context) => const IntroPage());
    case HomePage.pageName:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case CreateTaskPge.pageName:
      return PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                const CreateTaskPge(),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: Offset(0, 1), end: Offset(0, 0)),
            ),
            child: child,
          );
        },
      );
    case ViewNotes.pageName:
      return CupertinoPageRoute(
        builder: (context) => ViewNotes(notepad: rs.arguments as NoteModel),
        settings: RouteSettings(arguments: rs),
      );
    case ViewImage.pageName:
      return MaterialPageRoute(
        builder: (context) {
          final args = rs.arguments as Map<String, dynamic>;

          final index = args['index'] as int;
          final title = args['title'] as String;
          final subTitle = args['subTitle'] as String;
          final description = args['description'] as String;
          final notepad = args['notepad'] as NoteModel;
          return ViewImage(
            notepad: notepad,
            index: index,
            description: description,
            subTitle: subTitle,
            title: title,
          );
        },
        settings: rs,
      );
    default:
      return CupertinoPageRoute(builder: (context) => const HomePage());
  }
}
