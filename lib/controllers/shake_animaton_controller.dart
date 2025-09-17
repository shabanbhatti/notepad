import 'dart:async';

import 'package:flutter/material.dart';

class ShakeAnimationController extends ChangeNotifier {
  
 late AnimationController animationController;
  late Animation<Offset> slide;

void myAnimation(TickerProvider tickerProvider){

 animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 25),
    );

    slide = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.1, 0.0),
    ).animate(animationController);

}

@override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

void runShakeWithTimer() {
    
    int count = 0;
    const int maxShakes = 8;

    Timer.periodic(const Duration(milliseconds: 25), (timer) {
      if (count >= maxShakes) {
        timer.cancel();
        animationController.reset();
      } else {
        animationController.forward().then((_) {
          animationController.reverse();
        });
        count++;
      }
    });
  }


}