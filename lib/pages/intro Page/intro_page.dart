import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/pages/Home%20page/home_page.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  static const pageName = '/';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 500),
    )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    scale = Tween<double>(begin: 0.85, end: 1.0).animate(animationController);

    animationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(HomePage.pageName);
      }
    });
  }
@override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print('Intro CALLED--------');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: scale,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 50,
                child: Icon(
                  Icons.note,
                  size: 60,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Notepad',
                style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
